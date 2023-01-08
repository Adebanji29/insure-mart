import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/new_claim_provider.dart';
import '../../utils/app_theme.dart';
import '../../widget/alert_dialog.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';
import '../../widget/text_fields.dart';

class NewClaim extends StatefulWidget {
  const NewClaim({Key? key}) : super(key: key);
  static const route = '/newClaim';

  @override
  State<NewClaim> createState() => _NewClaimState();
}

class _NewClaimState extends State<NewClaim> {
  final List<String> _typesOfLosses = [
    'Personal only',
    '3rd Party only',
    'Personal & 3rd Party',
  ];
  String _typeOfLoss = 'Personal only';
  // final String _regNum = '';
  late Future<List<String>> futureData;
  late List<String> _regNumList;
  late TextEditingController _dateOfAccident;
  late TextEditingController _mechanicContactNumber;
  late TextEditingController _estimateOfrepairs;
  late TextEditingController _rdestimateOfrepairs;
  late TextEditingController _descriptionOfDangedProperty;
  late TextEditingController _descriptionOfAccident;

  User? currentUser = FirebaseAuth.instance.currentUser;
  String ClaimID = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    final newClaimProvider = context.read<NewClaimProvider>();
    futureData = newClaimProvider.getUserRegNum();
    _regNumList = newClaimProvider.regNumList;
    _dateOfAccident = TextEditingController();
    _mechanicContactNumber = TextEditingController();
    _estimateOfrepairs = TextEditingController();
    _rdestimateOfrepairs = TextEditingController();
    _descriptionOfDangedProperty = TextEditingController();
    _descriptionOfAccident = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dateOfAccident.dispose();
    _mechanicContactNumber.dispose();
    _estimateOfrepairs.dispose();
    _rdestimateOfrepairs.dispose();
    _descriptionOfDangedProperty.dispose();
    _descriptionOfAccident.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Claim Discharge'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: FutureBuilder<List<String>>(
            future: futureData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final watchProvider = context.watch<NewClaimProvider>();
                final readProvider = context.read<NewClaimProvider>();
                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 132),
                  children: [
                    label('Type of Loss'),
                    CustomDropDownButton(
                      value: _typeOfLoss,
                      items: _typesOfLosses,
                      onChanged: (val) {
                        _typeOfLoss = val!;
                      },
                    ),
                    if (_typeOfLoss.toLowerCase().contains('personal')) ...[
                      const CustomSizedBox(height: 25),
                      label('Reg number of damaged car'),
                      CustomDropDownButton(
                        label: 'Reg number',
                        value: readProvider.regNum,
                        items: _regNumList,
                        onChanged: (val) {
                          readProvider.setRegNum(val!);
                        },
                      ),
                    ],
                    if (_typeOfLoss.toLowerCase().contains('3rd')) ...[
                      const CustomSizedBox(height: 25),
                      label('Description of danged property'),
                      CustomTextField(
                        controller: _descriptionOfDangedProperty,
                        label: 'Description of danged property',
                      )
                    ],
                    const CustomSizedBox(height: 25),
                    label('Date of loss/accident'),
                    CustomTextField(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1960),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          _dateOfAccident.text = formattedDate;
                        }
                      },
                      focusColor: InsuremartTheme.blue2,
                      label: 'Date of loss/accident',
                      controller: _dateOfAccident,
                      readOnly: true,
                      suffix: const Icon(
                        Icons.calendar_month,
                        color: InsuremartTheme.white3,
                      ),
                      //
                    ),
                    // const CustomSizedBox(height: 25),
                    // label('Mechanic or Engineer Contact Number'),
                    // CustomTextField(
                    //   controller: _mechanicContactNumber,
                    //   // readOnly: true,
                    //   label: 'Phone Number',
                    // ),
                    if (_typeOfLoss.toLowerCase().contains('personal')) ...[
                      const CustomSizedBox(height: 25),
                      label(_typeOfLoss.toLowerCase().contains('only')
                          ? 'Estimate of repairs'
                          : 'Estimate of repairs (My own vehicle)'),
                      CustomTextField(
                        controller: _estimateOfrepairs,
                        label: 'Estimate of repairs',
                        keyBoardType: TextInputType.number,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            locale: 'en_NG',
                            symbol: '₦',
                            decimalDigits: 2,
                            enableNegative: false,
                          )
                        ],
                      ),
                    ],
                    if (_typeOfLoss.toLowerCase().contains('3rd')) ...[
                      const CustomSizedBox(height: 25),
                      label('3rd party Estimate of repairs'),
                      CustomTextField(
                        controller: _rdestimateOfrepairs,
                        label: 'Estimate of repairs',
                        keyBoardType: TextInputType.number,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            locale: 'en_NG',
                            symbol: '₦',
                            decimalDigits: 2,
                            enableNegative: false,
                          )
                        ],
                      ),
                    ],
                    const CustomSizedBox(height: 25),
                    label('Description of loss/accident'),
                    Container(
                      height: 117,
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: InsuremartTheme.white2,
                        border: Border.all(color: InsuremartTheme.white3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _descriptionOfAccident,
                        minLines: 1,
                        maxLines: 5,
                        maxLength: 1000,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: const InputDecoration(
                          hintText: 'Description of loss/accident',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // const CustomSizedBox(height: 25),
                    // label('Record yourself narrating incident (optional)'),
                    // ImageContainer(imageFile: _narrateFile,
                    //     imageUrl: ""),
                    const CustomSizedBox(height: 25),
                    label('Upload Sworn Avidivit or Police Report'),
                    ImageContainer(
                      imageFile: watchProvider.swornAvidivit,
                      which: 'swpr',
                    ),
                    if (_typeOfLoss.toLowerCase().contains('3rd')) ...[
                      const CustomSizedBox(height: 25),
                      label('Interim police report (theft)'),
                      ImageContainer(
                        imageFile: watchProvider.interimPoliceReport,
                        which: 'ipr',
                      ),
                      const CustomSizedBox(height: 25),
                      label('Final police report (theft)'),
                      ImageContainer(
                        imageFile: watchProvider.finalPoliceReport,
                        which: 'fpr',
                      ),
                    ],
                    if (_typeOfLoss.toLowerCase().contains('personal')) ...[
                      const CustomSizedBox(height: 25),
                      label(
                          'Upload image or picture of damage while showing registration number 1'),
                      ImageContainer(
                        imageFile: watchProvider.imageWithRegNum1,
                        which: 'irn1',
                      ),
                      const CustomSizedBox(height: 25),
                      label(
                          'Upload image or picture of damage while showing registration number 2'),
                      ImageContainer(
                        imageFile: watchProvider.imageWithRegNum2,
                        which: 'irn2',
                      ),
                    ],
                    if (_typeOfLoss.toLowerCase().contains('3rd')) ...[
                      const CustomSizedBox(height: 25),
                      label(
                          'Upload image or picture of 3rd party damage while showing registration number 1'),
                      ImageContainer(
                        imageFile: watchProvider.rdPartyImageWithRegNum1,
                        which: '3irn1',
                      ),
                      const CustomSizedBox(height: 25),
                      label(
                          'Upload image or picture of 3rd party damage while showing registration number 2'),
                      ImageContainer(
                        imageFile: watchProvider.rdPartyImageWithRegNum2,
                        which: '3irn2',
                      ),
                    ],
                    if (_typeOfLoss.toLowerCase().contains('personal')) ...[
                      const CustomSizedBox(height: 25),
                      label('Upload more images of damage (optional)'),
                      ImageContainer(
                        imageFile: watchProvider.additionalImage1,
                        which: 'mi1',
                      ),
                      const CustomSizedBox(height: 25),
                      label('Upload more images of damage (optional)'),
                      ImageContainer(
                        imageFile: watchProvider.additionalImage2,
                        which: 'mi2',
                      ),
                      const CustomSizedBox(height: 25),
                      label('Upload more images of damage (optional)'),
                      ImageContainer(
                        imageFile: watchProvider.additionalImage3,
                        which: 'mi3',
                      ),
                    ],
                    if (_typeOfLoss.toLowerCase().contains('3rd')) ...[
                      const CustomSizedBox(height: 25),
                      label(
                          'Upload more images of 3rd party damage (optional)'),
                      ImageContainer(
                        imageFile: watchProvider.rdPartyadditionalImage1,
                        which: '3mi1',
                      ),
                      const CustomSizedBox(height: 25),
                      label(
                          'Upload more images of 3rd party damage (optional)'),
                      ImageContainer(
                        imageFile: watchProvider.rdPartyadditionalImage2,
                        which: '3mi2',
                      ),
                      const CustomSizedBox(height: 25),
                      label(
                          'Upload more images of 3rd party damage (optional)'),
                      ImageContainer(
                        imageFile: watchProvider.rdPartyadditionalImage3,
                        which: '3mi3',
                      ),
                    ],
                    const CustomSizedBox(height: 25),
                    AuthButton(
                        title: 'CONTINUE',
                        isLoading: watchProvider.submiting,
                        loadingTitle: '',
                        onPressed: () {
                          readProvider
                              .submitClaim(
                                typeOfLoss: _typeOfLoss,
                                descriptionOfDamagedProperty:
                                    _descriptionOfDangedProperty.text.trim(),
                                dateOfAccident: _dateOfAccident.text.trim(),
                                estimateOfRepairs:
                                    _estimateOfrepairs.text.trim(),
                                rdEstimateOfRepairs:
                                    _rdestimateOfrepairs.text.trim(),
                                descriptionOfLoss:
                                    _descriptionOfAccident.text.trim(),
                              )
                              .then((value) => Navigator.of(context).pop());
                        }),
                  ],
                );
              }
            }),
      ),
    );
  }
}

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    Key? key,
    required this.imageFile,
    required this.which,
    this.imageOnly = true,
    this.isClaim = true,
  }) : super(key: key);
  final File? imageFile;
  final String which;
  final bool imageOnly;
  final bool isClaim;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => ImageSourceDialogBox(
            which: widget.which,
            isClaim: widget.isClaim,
          ),
        );
        // imageSourceDialogBox(widget.which);
      },
      child: Container(
        height: 69,
        decoration: BoxDecoration(
          color: InsuremartTheme.white2,
          border: Border.all(color: InsuremartTheme.white3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: widget.imageFile != null
            ? Image.file(
                widget.imageFile!,
                fit: BoxFit.cover,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/cloud.png'),
                  const SizedBox(width: 10),
                  Text(
                    'Upload\njpg - png${widget.imageOnly ? '' : ' - mp4'}',
                    textAlign: TextAlign.center,
                    style: InsuremartTheme.lightTextTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: InsuremartTheme.white3,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
