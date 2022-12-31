import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../models/user_model.dart';
import '../../provider/user_provider.dart';
import '../../utils/app_theme.dart';
import '../../widget/buttons.dart';
import '../../widget/text_fields.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static const route = '/editProfile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final List<String> _genderList = ['Male', 'Female'];
  late GlobalKey<FormState> _formKey;
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _gender;
  late TextEditingController _dob;
  late TextEditingController _address;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _gender = TextEditingController();
    _dob = TextEditingController();
    _address = TextEditingController();
    super.initState();
  }

  String imageUrl = "";
  File pickedImage = File("");
  XFile? _imgXfile;
  bool uploading = false;

  Future<void> getImage({required ImageSource source}) async {
    _imgXfile = await ImagePicker().pickImage(source: source);
    if (_imgXfile != null) {
      pickedImage = File(_imgXfile!.path);
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
      Reference storageReference =
          FirebaseStorage.instance.ref().child("UserImage/${user?.uid}");
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user?.uid)
          .update({"imgUrl": imageUrl});

      setState(() {
        uploading = false;
      });
    } else {
      Fluttertoast.showToast(msg: "Select an Image");
    }
  }

  Future<void> userDetailUpdate() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (_formKey.currentState!.validate()) {
      if (_gender.text.isEmpty || _dob.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please fill in all details correctly");
      } else if (_address.text.length > 40) {
        Fluttertoast.showToast(
            msg: "address should not be more than 40 characters");
      } else {
        setState(() {
          uploading = true;
        });
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user?.uid)
            .update({
          "firstname": _firstName.text.trim(),
          "lastname": _lastName.text.trim(),
          "gender": _gender.text.trim(),
          "dob": _dob.text.trim(),
          "hAddress": _address.text.trim(),
        });
        _formKey.currentState!.reset();

        Navigator.pop(context);
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill in all details correctly");
    }
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _gender.dispose();
    _dob.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userprovider = Provider.of<UserProvider>(context);
    userprovider.getUserData();
    List<UserModel> userModel = userprovider.getUsermodelList;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: userModel
                    .map((e) => SizedBox(
                          height: 690,
                          child: ListView(
                            children: [
                              uploading == true
                                  ? const LinearProgressIndicator()
                                  : Container(),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CircleAvatar(
                                              radius: 70,
                                              backgroundImage: _imgXfile == null
                                                  ? (e.imgUrl == ""
                                                      ? const AssetImage(
                                                          'assets/images/user.jpg')
                                                      : NetworkImage(e.imgUrl
                                                              .toString())
                                                          as ImageProvider)
                                                  : FileImage(pickedImage),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 100, top: 110),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: GestureDetector(
                                            onTap: () {
                                              myDialogBox();
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Icon(
                                                Icons.camera_alt_rounded,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 30),
                                  MediumButton(
                                      title: 'Upload Image',
                                      onPressed: () async {
                                        uploadImage(image: pickedImage);
                                      }),
                                ],
                              ),
                              const SizedBox(height: 30),
                              label('First Name'),
                              CustomTextField(
                                  focusColor: InsuremartTheme.blue2,
                                  label: e.firstname,
                                  controller: _firstName,
                                  validator: (value) {
                                    if (value.toString().isNotEmpty &&
                                        value.length > 2) {
                                      return null;
                                    } else if (value.toString().isNotEmpty &&
                                        value.length < 3) {
                                      return "name cannot be too short";
                                    } else {
                                      return " Enter your first name";
                                    }
                                  }),
                              const SizedBox(height: 25),
                              label('Last Name'),
                              CustomTextField(
                                  focusColor: InsuremartTheme.blue2,
                                  label: e.lastname,
                                  controller: _lastName,
                                  validator: (value) {
                                    if (value.toString().isNotEmpty &&
                                        value.length > 2) {
                                      return null;
                                    } else if (value.toString().isNotEmpty &&
                                        value.length < 3) {
                                      return "last name cannot be too short";
                                    } else {
                                      return " Enter  your last name";
                                    }
                                  }),
                              const SizedBox(height: 25),
                              label('Gender'),
                              CustomDropDownButton(
                                label: e.gender == "" ? ('Gender') : (e.gender),
                                focusColor: InsuremartTheme.blue2,
                                items: _genderList,
                                onChanged: (val) {
                                  _gender.text = val!;
                                },
                              ),
                              const SizedBox(height: 25),
                              label('Date of Birth'),
                              GestureDetector(
                                onTap: () => showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime.now(),
                                ),
                                child: CustomTextField(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1960),
                                      lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                      _dob.text = formattedDate;
                                      print(_dob.text);
                                    }
                                  },
                                  focusColor: InsuremartTheme.blue2,
                                  label:
                                      e.dob == "" ? ('Date of Birth') : (e.dob),
                                  controller: _dob,
                                  readOnly: true,
                                  suffix: const Icon(
                                    Icons.calendar_month,
                                    color: InsuremartTheme.white3,
                                  ),
                                  //
                                ),
                              ),
                              const SizedBox(height: 25),
                              label('Home Address'),
                              CustomTextField(
                                  focusColor: InsuremartTheme.blue2,
                                  label: e.hAddress == ""
                                      ? ('Home Address')
                                      : (e.hAddress),
                                  controller: _address,
                                  keyBoardType: TextInputType.streetAddress,
                                  validator: (value) {
                                    if (value.toString().isNotEmpty &&
                                        value.length > 2) {
                                      return null;
                                    } else if (value.toString().isNotEmpty &&
                                        value.length < 3) {
                                      return "home address cannot be too short";
                                    } else {
                                      return " Enter  home address";
                                    }
                                  }),
                              const SizedBox(height: 25),
                              LongButton(
                                  title: 'Save',
                                  onPressed: () {
                                    userDetailUpdate();
                                  }),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
