import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/claim_provider.dart';
import '../../utils/app_theme.dart';
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
  final List<String> _typesOfLosses = const [
    'Personal only',
    '3rd Party only',
    'Personal & 3rd Party',
  ];
  String _typeOfLoss = 'Personal only';
  late TextEditingController _dateOfAccident;
  // late TextEditingController _mechanicContactNumber;
  late TextEditingController _estimateOfrepairs;
  late TextEditingController _rdestimateOfrepairs;
  late TextEditingController _descriptionOfDangedProperty;
  late TextEditingController _descriptionOfAccident;

  File? _narrateFile;
  String? policereportImg;
  String? regnum1img;
  String? regnum2Img;
  String? policereport1;
  String? policereport2;
  String? partyregnum1img;
  String? partyregnum2Img;
  String? moreimages1;
  String? moreimages2;
  String? moreimages3;
  String? partymoreimages1;
  String? partymoreimages2;
  String? partymoreimages3;
  bool uploading = false;

  // User? currentUser = FirebaseAuth.instance.currentUser;
  // String ClaimID = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    _dateOfAccident = TextEditingController();
    // _mechanicContactNumber = TextEditingController();
    _estimateOfrepairs = TextEditingController();
    _rdestimateOfrepairs = TextEditingController();
    _descriptionOfDangedProperty = TextEditingController();
    _descriptionOfAccident = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dateOfAccident.dispose();
    // _mechanicContactNumber.dispose();
    _estimateOfrepairs.dispose();
    _rdestimateOfrepairs.dispose();
    _descriptionOfDangedProperty.dispose();
    _descriptionOfAccident.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final claimProvider = context.read<ClaimProvider>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Claim'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 132),
          children: [
            label('Type of Loss'),
            CustomDropDownButton(
              items: _typesOfLosses,
              value: _typeOfLoss,
              onChanged: (val) {
                _typeOfLoss = val as String;
              },
            ),
            if (_typeOfLoss.toLowerCase().contains('personal')) ...[
              const CustomSizedBox(height: 25),
              label('Reg number of damaged car'),
              CustomDropDownButton(
                label: 'Reg number',
                items: claimProvider.reglist,
                value: claimProvider.regNum,
                onChanged: (val) {
                  claimProvider.rregNum(val as String);
                  // _regNum = val as String;
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
              readOnly: true,
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
              ),
            ],
            if (_typeOfLoss.toLowerCase().contains('3rd')) ...[
              const CustomSizedBox(height: 25),
              label('3rd party Estimate of repairs'),
              CustomTextField(
                controller: _rdestimateOfrepairs,
                label: 'Estimate of repairs',
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
                maxLines: 7,
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
            // ImageContainer(imageFile: _narrateFile, imageUrl: ""),
            const CustomSizedBox(height: 25),
            label('Upload Sworn Avidivit or Police Report'),
            ImageContainer(imageFile: _narrateFile, imageUrl: policereportImg),
            if (_typeOfLoss.toLowerCase().contains('3rd')) ...[
              const CustomSizedBox(height: 25),
              label('Interim police report (theft)'),
              ImageContainer(imageFile: _narrateFile, imageUrl: policereport1),
              const CustomSizedBox(height: 25),
              label('Final police report (theft)'),
              ImageContainer(imageFile: _narrateFile, imageUrl: policereport2),
            ],
            if (_typeOfLoss.toLowerCase().contains('personal')) ...[
              const CustomSizedBox(height: 25),
              label(
                  'Upload image or picture of damage while showing registration number 1'),
              ImageContainer(
                imageFile: _narrateFile,
                imageUrl: regnum1img,
              ),
              const CustomSizedBox(height: 25),
              label(
                  'Upload image or picture of damage while showing registration number 2'),
              ImageContainer(
                imageFile: _narrateFile,
                imageUrl: regnum2Img,
              ),
            ],
            if (_typeOfLoss.toLowerCase().contains('3rd')) ...[
              const CustomSizedBox(height: 25),
              label(
                  'Upload image or picture of 3rd party damage while showing registration number 1'),
              ImageContainer(
                imageFile: _narrateFile,
                imageUrl: partyregnum1img,
              ),
              const CustomSizedBox(height: 25),
              label(
                  'Upload image or picture of 3rd party damage while showing registration number 2'),
              ImageContainer(
                imageFile: _narrateFile,
                imageUrl: partyregnum2Img,
              ),
            ],
            if (_typeOfLoss.toLowerCase().contains('personal')) ...[
              const CustomSizedBox(height: 25),
              label('Upload more images of damage (optional)'),
              ImageContainer(
                imageFile: _narrateFile,
                imageUrl: moreimages1,
              ),
              const CustomSizedBox(height: 25),
              label('Upload more images of damage (optional)'),
              ImageContainer(
                imageFile: _narrateFile,
                imageUrl: moreimages2,
              ),
              const CustomSizedBox(height: 25),
              label('Upload more images of damage (optional)'),
              ImageContainer(
                imageFile: _narrateFile,
                imageUrl: moreimages3,
              ),
            ],
            if (_typeOfLoss.toLowerCase().contains('3rd')) ...[
              const CustomSizedBox(height: 25),
              label('Upload more images of 3rd party damage (optional)'),
              ImageContainer(
                imageFile: _narrateFile,
                imageUrl: partymoreimages1,
              ),
              const CustomSizedBox(height: 25),
              label('Upload more images of 3rd party damage (optional)'),
              ImageContainer(
                imageFile: _narrateFile,
                imageUrl: partymoreimages2,
              ),
              const CustomSizedBox(height: 25),
              label('Upload more images of 3rd party damage (optional)'),
              ImageContainer(
                imageFile: _narrateFile,
                imageUrl: partymoreimages3,
              ),
            ],
            const CustomSizedBox(height: 25),
            LongButton(
                title: 'CONTINUE',
                onPressed: () => claimProvider.saveClaimInfo),
          ],
        ),
      ),
    );
  }
}

class ImageContainer extends StatefulWidget {
  ImageContainer({Key? key, required this.imageFile, required this.imageUrl})
      : super(key: key);
  File? imageFile;
  String? imageUrl;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  XFile? _imgXfile;
  bool uploading = false;

  Future<void> getImage({required ImageSource source}) async {
    _imgXfile = await ImagePicker().pickImage(source: source);
    if (_imgXfile != null) {
      widget.imageFile = File(_imgXfile!.path);
      setState(() {
        _imgXfile;
      });
    }
  }

  Future<void> myDialogBox() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera),
                    title: const Text("Pick from Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library_outlined),
                    title: const Text("Pick from Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  uploadImage({required File image}) async {
    if (_imgXfile != null) {
      setState(() {
        uploading = true;
      });
      User? user = FirebaseAuth.instance.currentUser;
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("UserClaimImages")
          .child(user!.uid);
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      widget.imageUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        uploading = false;
      });
    } else {
      Fluttertoast.showToast(msg: "Select an Image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myDialogBox();
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
                    'Upload\njpg - png - mp4',
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
