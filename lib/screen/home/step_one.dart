// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:insuremart/screen/home/step_two.dart';
import 'package:provider/provider.dart';
import '../../Backend models/insurance_model.dart';
import '../../provider/new_insurance_provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';
import '../../widget/save_bottom_sheet.dart';
import '../../widget/text_fields.dart';
import 'new_insurance.dart';

class StepOne extends StatefulWidget {
  final InsuranceModel model;
  const StepOne({super.key, required this.model});
  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  User? currentUser = FirebaseAuth.instance.currentUser;
  String step1ID = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  String _selectedCarMake = "Acura";
  var CarMake = Utils.CarMake;
  List CarMakes = [];

  CarMakeDependentDropDown() {
    CarMake.forEach((key, value) {
      CarMakes.add(key);
    });
  }

  String _selectedCarModel = "Legend";
  var CarModel = Utils.CarModel;
  List CarModels = [];

  CarModelDependentDropDown(carmodelShortname) {
    CarModel.forEach((key, value) {
      if (carmodelShortname == value) {
        CarModels.add(key);
      }
    });
    _selectedCarModel = CarModels[0];
  }

  late TextEditingController _name;
  late TextEditingController _vehicleColor;
  late TextEditingController _regNumber;
  late TextEditingController _chassisNumber;
  late TextEditingController _engineNumber;
  late TextEditingController _vehicleValue;
  late TextEditingController _covertype;
  late TextEditingController _insuranceperiod;

  @override
  void initState() {
    CarMakeDependentDropDown();
    _name = TextEditingController();
    _vehicleColor = TextEditingController();
    _regNumber = TextEditingController();
    _chassisNumber = TextEditingController();
    _engineNumber = TextEditingController();
    _vehicleValue = TextEditingController();
    _covertype = TextEditingController();
    _insuranceperiod = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _vehicleColor.dispose();
    _regNumber.dispose();
    _chassisNumber.dispose();
    _engineNumber.dispose();
    _vehicleValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = context.read<NewInsuranceManager>();
    return Form(
      key: _formkey,
      child: ListView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 40,
        ),
        children: [
          uploading == true ? const LinearProgressIndicator() : Container(),
          label('Full Name of User'),
          CustomTextField(
            controller: _name,
            label: 'Enter name',
            validator: (value) {
              if (value.toString().isNotEmpty && value.length > 2) {
                return null;
              } else if (value.toString().isNotEmpty && value.length < 3) {
                return "Username cannot be too short";
              } else if (value.toString().isEmpty) {
                return "please fill in your name";
              }
              return null;
            },
          ),
          const CustomSizedBox(height: 25),
          label('Car Make'),

          DropdownButtonFormField2(
            style: InsuremartTheme.lightTextTheme.bodyText1!
                .copyWith(fontWeight: FontWeight.w400),
            decoration: buildTextDecoration(
                label: "Select Car Make", focusColor: InsuremartTheme.green2),
            icon: const Icon(Icons.expand_more),
            iconOnClick: const Icon(Icons.expand_less),
            alignment: AlignmentDirectional.bottomStart,
            isExpanded: true,
            value: _selectedCarMake,
            onChanged: (newvalue) {
              setState(() {
                CarModels = [];
                CarModelDependentDropDown(CarMake[newvalue]);
                _selectedCarMake = '$newvalue';
              });
            },
            validator: (value) {
              if (value.toString().isNotEmpty) {
                return null;
              } else {
                return "  select a Car make";
              }
            },
            items: CarMakes.map((carmake) {
              return DropdownMenuItem(
                value: carmake,
                child: Text(carmake,
                    style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w400,
                    )),
              );
            }).toList(),
          ),

          const CustomSizedBox(height: 25),
          label('Car Model'),
          DropdownButtonFormField2(
            style: InsuremartTheme.lightTextTheme.bodyText1!
                .copyWith(fontWeight: FontWeight.w400),
            decoration: buildTextDecoration(
                label: "Select Car Model", focusColor: InsuremartTheme.green2),
            icon: const Icon(Icons.expand_more),
            iconOnClick: const Icon(Icons.expand_less),
            alignment: AlignmentDirectional.bottomStart,
            isExpanded: true,
            value: _selectedCarModel,
            onChanged: (newvalue) {
              setState(() {
                _selectedCarModel = '$newvalue';
              });
            },
            validator: (value) {
              if (value.toString().isNotEmpty) {
                return null;
              } else {
                return " select your car model";
              }
            },
            items: CarModels.map((carmake) {
              return DropdownMenuItem(
                value: carmake,
                child: Text(carmake,
                    style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w400,
                    )),
              );
            }).toList(),
          ),
          const CustomSizedBox(height: 25),
          label('Type of Cover'),
          CustomDropDownButton(
            label: 'Type of cover',
            onChanged: (String? val) {
              _covertype.text = val!;
            },
            items: Utils.coverList,
          ),
          const CustomSizedBox(height: 25),
          label('Colour of vehicle'),
          CustomTextField(
            controller: _vehicleColor,
            label: 'Colour',
            validator: (value) {
              if (value.toString().isNotEmpty && value.length > 2) {
                return null;
              } else if (value.toString().isNotEmpty && value.length < 3) {
                return "Fill in correct details";
              } else {
                return " Enter  the color";
              }
            },
          ),
          const CustomSizedBox(height: 25),
          label('Value of Car'),
          CustomTextField(
            validator: (value) {
              if (value.toString().isNotEmpty && value.length > 2) {
                return null;
              } else if (value.toString().isNotEmpty && value.length < 5) {
                return "the value cannot be too short";
              } else {
                return " Enter  the vehicle value";
              }
            },
            controller: _vehicleValue,
            label: '100000 and above',
            keyBoardType: TextInputType.phone,
            inputFormatters: [
              CurrencyTextInputFormatter(
                locale: 'en_NG',
                symbol: '₦',
                decimalDigits: 2,
                enableNegative: false,
              ),
            ],
          ),
          const CustomSizedBox(height: 25),
          label('Registration Number'),
          CustomTextField(
            validator: (value) {
              if (value.toString().isNotEmpty && value.length > 2) {
                return null;
              } else if (value.toString().isNotEmpty && value.length < 5) {
                return "Registration number cannot be too short";
              } else {
                return " Enter the registration number";
              }
            },
            controller: _regNumber,
            label: 'eg. 345AD7H3',
            textCapitalization: TextCapitalization.characters,
          ),
          const CustomSizedBox(height: 25),
          label('Chassis Number'),
          CustomTextField(
            validator: (value) {
              if (value.toString().isNotEmpty && value.length > 2) {
                return null;
              } else if (value.toString().isNotEmpty && value.length < 5) {
                return "chasis number cannot be too short";
              } else {
                return "Enter chasis number";
              }
            },
            controller: _chassisNumber,
            label: 'Chassis Number',
          ),
          const CustomSizedBox(height: 25),
          label('Engine Number'),
          CustomTextField(
            validator: (value) {
              if (value.toString().isNotEmpty && value.length > 2) {
                return null;
              } else if (value.toString().isNotEmpty && value.length < 5) {
                return "Engine number cannot be too short";
              } else {
                return " Enter the engine number";
              }
            },
            controller: _engineNumber,
            label: 'Engine Number',
          ),
          const CustomSizedBox(height: 25),
          label('Period of Insurance'),
          CustomDropDownButton(
            onChanged: (String? val) {
              _insuranceperiod.text = val!;
            },
            items: const ['2 months', '4 months', '6 months', '12 months'],
          ),
          // const CustomSizedBox(height: 25),
          // LongButton(title: 'SAVE', onPressed: (){
          //   validateUploadForm();
          //
          // }),
          const CustomSizedBox(height: 10),
          LongButton(
              title: 'CONTINUE',
              onPressed: () {
                validateUploadForm();
              }),
          const CustomSizedBox(height: 10),
          LongButton(
            title: 'SAVE AND CONTINUE LATER',
            onPressed: () {
              buildBottomSheet(context);
            },
            color: InsuremartTheme.white1,
            textColor: InsuremartTheme.blue2,
            isBorder: true,
          ),
        ],
      ),
    );
  }

  getModels() async {
    final ref = context.read<NewInsuranceManager>();
    setState(() {
      widget.model.username = _name.text;
      widget.model.carmake = _selectedCarMake;
      widget.model.carmodel = _selectedCarModel;
      widget.model.coverType = _covertype.text;
      widget.model.vehicleColor = _vehicleColor.text;
      widget.model.sumInsured = double.parse(_vehicleValue.text);
      widget.model.registrationNumber = _regNumber.text;
      widget.model.chasisNumber = _chassisNumber.text;
      widget.model.engineNumber = _engineNumber.text;
      widget.model.insurancePeriod = _insuranceperiod.text;
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewInsurance(
                  myModel: widget.model,
                  summary: 0,
                )));
    ref.nextStep();
  }

  // savestep1CarInsuranceInfo()async
  // {
  //
  //  await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(currentUser!.uid)
  //       .collection("Step1Data")
  //       .doc(step1ID)
  //       .set(
  //       {
  //         "step1ID": step1ID,
  //         "userId": currentUser!.uid,
  //         "username":_name.text.trim(),
  //         "Car Make": _selectedCarMake.trim(),
  //         "Car Model": _selectedCarModel.trim(),
  //         "Type Of Cover":_covertype.text.trim(),
  //         "Colour Of vehicle": _vehicleColor.text.trim(),
  //         "Value Of Car": _vehicleValue.text.trim(),
  //         "Registration No":_regNumber.text.trim(),
  //         "Chassis Number": _chassisNumber.text.trim(),
  //         "Engine Number":_engineNumber.text.trim(),
  //         "Period Of Insurance": _insuranceperiod.text.trim(),
  //         "uploaded Date":DateTime.now(),
  //       });
  //
  //   setState(() {
  //     uploading= false;
  //     step1ID = DateTime.now().millisecondsSinceEpoch.toString();
  //
  //   });
  //
  // }

  validateUploadForm() async {
    if (_formkey.currentState!.validate()) {
      if (_selectedCarModel.isEmpty &&
          _selectedCarMake.isEmpty &&
          _covertype.toString().isEmpty) {
        Fluttertoast.showToast(msg: "Please fill in all details correctly.");
      } else {
        setState(() {
          uploading = true;
        });

        getModels();
        // savestep1CarInsuranceInfo();

        setState(() {
          uploading = false;
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill in all details correctly.");
    }
  }
}
