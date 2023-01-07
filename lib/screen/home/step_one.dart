import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insuremart_app/uppercaseFormatter/uppercase_formatter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Backend models/insurance_model.dart';
import '../../computation/computation.dart';
import '../../provider/new_insurance_provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';
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
  String step1ID = DateTime
      .now()
      .millisecondsSinceEpoch
      .toString();

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
  late TextEditingController _insuranceperiod;
  late TextEditingController _policydate;
  late Computation computation;

  @override
  void initState() {
    CarMakeDependentDropDown();
    _name = TextEditingController();
    _vehicleColor = TextEditingController();
    _regNumber = TextEditingController();
    _chassisNumber = TextEditingController();
    _engineNumber = TextEditingController();
    _vehicleValue = TextEditingController();
    _insuranceperiod = TextEditingController();
    _policydate = TextEditingController();
    computation = Computation(model: widget.model);
    computation.getClassOfInsurane();
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
    final readProvider = context.read<NewInsuranceManager>();
    return Form(
      key: _formkey,
      child: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text('Tap back again to exit')),
        child: ListView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 40,
          ),
          children: [
            label('Full Name of User'),
            CustomTextField(
              controller: _name,
              label: 'Enter name',
              validator: (value) {
                if (value
                    .toString()
                    .isNotEmpty && value.length > 2) {
                  return null;
                } else if (value
                    .toString()
                    .isNotEmpty && value.length < 3) {
                  return "Username cannot be too short";
                } else if (value
                    .toString()
                    .isEmpty) {
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
                if (value
                    .toString()
                    .isNotEmpty) {
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
                  label: "Select Car Model",
                  focusColor: InsuremartTheme.green2),
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
                if (value
                    .toString()
                    .isNotEmpty) {
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
              items: readProvider.coverList,
              value: readProvider.typeOfCover,
              onChanged: (String? val) {
                readProvider.setTypeOfCover(val!);
              },
            ),

            if (readProvider.typeOfCover != null &&
                !readProvider.typeOfCover!.contains('party')) ...[

              const CustomSizedBox(height: 25),
              label('Value of Car'),
              CustomTextField(
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

            ],

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
              inputFormatters: [
                UpperCaseFormatter(),
                FilteringTextInputFormatter.allow(RegExp('[0-9A-Z]'))
              ],
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
              inputFormatters: [
                UpperCaseFormatter(),
                FilteringTextInputFormatter.allow(RegExp('[0-9A-Z]'))
              ],
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
              inputFormatters: [
                UpperCaseFormatter(),
                FilteringTextInputFormatter.allow(RegExp('[0-9A-Z]'))
              ],
              controller: _engineNumber,
              label: 'Engine Number',

            ),

            const CustomSizedBox(height: 25),
            label('Colour of vehicle'),
            CustomTextField(
              controller: _vehicleColor,
              label: 'Colour',
              validator: (value) {
                if (value
                    .toString()
                    .isNotEmpty && value.length > 2) {
                  return null;
                } else if (value
                    .toString()
                    .isNotEmpty && value.length < 3) {
                  return "Fill in correct details";
                } else {
                  return " Enter  the color";
                }
              },
            ),
            const CustomSizedBox(height: 25),
            label('Policy Start Date'),
            CustomTextField(
              validator: (value) {
                if (value
                    .toString()
                    .isEmpty) {
                  return " Enter  the policy start date";
                } else {

                }
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 30)),
                );
                if (pickedDate != null) {
                  String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
                  _policydate.text = formattedDate;
                  print(_policydate.text);
                }
              },
              focusColor: InsuremartTheme.blue2,
              label: ('Policy Start Date'),
              controller: _policydate,
              readOnly: true,
              suffix: const Icon(
                Icons.calendar_month,
                color: InsuremartTheme.white3,
              ),
              //
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
                  !readProvider.typeOfCover.toString().contains("party")
                      ?
                  validateUploadFormForComprehensive()
                      : validateUploadFormForThirdParty();
                }),
            const CustomSizedBox(height: 10),
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
        ),
      ),
    );
  }

  getModelsComprehensive() async {
    final ref = context.read<NewInsuranceManager>();
    var insureClass = computation.getInsClass;
    setState(() {
      widget.model.username = _name.text;
      widget.model.carmake = _selectedCarMake;
      widget.model.carmodel = _selectedCarModel;
      widget.model.vehicleColor = _vehicleColor.text;
      widget.model.sumInsured =
          double.parse(
              _vehicleValue.text.toString().replaceAll(RegExp('[^0-9.]'), ''));
      widget.model.registrationNumber = _regNumber.text;
      widget.model.chasisNumber = _chassisNumber.text;
      widget.model.engineNumber = _engineNumber.text;
      widget.model.insurancePeriod = _insuranceperiod.text;
      widget.model.policyStartDate = _policydate.text;
      widget.model.coverType = ref.typeOfCover.toString();
      widget.model.insuranceClass = insureClass.toString();
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NewInsurance(
                  myModel: widget.model,
                )));
    ref.nextStep();
    print(widget.model.purchaceDate);
  }


  getModelsThirdParty() async {
    var insureClass = computation.getInsClass;
    final ref = context.read<NewInsuranceManager>();
    setState(() {
      widget.model.username = _name.text;
      widget.model.carmake = _selectedCarMake;
      widget.model.carmodel = _selectedCarModel;
      widget.model.vehicleColor = _vehicleColor.text;
      // widget.model.sumInsured =
      //     double.parse(_vehicleValue.text.toString().replaceAll(RegExp('[^0-9.]'), ''));
      widget.model.registrationNumber = _regNumber.text;
      widget.model.chasisNumber = _chassisNumber.text;
      widget.model.engineNumber = _engineNumber.text;
      widget.model.insurancePeriod = _insuranceperiod.text;
      widget.model.policyStartDate = _policydate.text;
      widget.model.coverType = ref.typeOfCover.toString();
      widget.model.insuranceClass = insureClass.toString();
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NewInsurance(
                  myModel: widget.model,
                )));
    ref.gotoStep(2);
    print(widget.model.policyStartDate);
  }


  validateUploadFormForComprehensive() async {
    if (_formkey.currentState!.validate()) {
      if (_selectedCarModel.isEmpty && _selectedCarMake.isEmpty) {
        Fluttertoast.showToast(msg: "Please fill in all details correctly.");
      }
      else if (_vehicleValue.text.isEmpty) {
        Fluttertoast.showToast(msg: "Enter the vehicle value");
      }
      else {
        getModelsComprehensive();
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill in all details correctly.");
    }
  }

  validateUploadFormForThirdParty() async {
    if (_formkey.currentState!.validate()) {
      if (_selectedCarModel.isEmpty || _selectedCarMake.isEmpty) {
        Fluttertoast.showToast(msg: "Please fill in all details correctly.");
      }
      else {
        getModelsThirdParty();
      }
    }
    else {
      Fluttertoast.showToast(msg: "Please fill in all details correctly.");
    }
  }



  }





