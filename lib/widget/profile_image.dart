import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../provider/user_provider.dart';

class ProfileImage extends StatelessWidget {
  String img = "";

  @override
  Widget build(BuildContext context) {
    UserProvider userprovider = Provider.of<UserProvider>(context);
    userprovider.getUserData();
    List<UserModel> userModel= userprovider.getUsermodelList;
        img=  userModel.elementAt(0).imgUrl.toString();
    {
      return CircleAvatar(
          radius: 70,
          backgroundImage:
          img == ''?  AssetImage("assets/images/user.jpg"):NetworkImage(img) as ImageProvider
      );
    }

  }
}
