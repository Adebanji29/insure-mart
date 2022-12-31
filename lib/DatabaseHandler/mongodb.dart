// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:mongo_dart/mongo_dart.dart';
// import 'package:shelf/shelf.dart';
// import 'package:shelf_router/shelf_router.dart';
// //import 'package:sevr/sevr.dart';
// import 'package:path/path.dart' as p;

// import '../models/user_model.dart';


// void start() async{
//   final db = await Db.create('mongodb+srv://Stephen:<password>@cluster0.su7effi.mongodb.net/user?retryWrites=true&w=majority');
//   await db.open();
//   final userCollection = db.collection('userinfo');
//   print('Database opened');

//   //print(await coll.find().toList());

//   //insert into DB
//   insert(UserModel user) async {
//     await userCollection.insertAll([user.toMap()]);
//   }


//   //select from DB
//    Future<Object> getDocuments() async {
//     try {
//       final users = await userCollection.find().toList();
//       return users;
//     } catch (e) {
//       print(e);
//       return Future(() => e);
//     }
//   }

//   //update DB
//   update(UserModel user) async {
//     var u = await userCollection.findOne({"email": user.email});
//     u!["tile"] = user.title;
//     u["firstname"] = user.firstname;
//     u["lastname"] = user.lastname;
//     await userCollection.save(u);
//   }

//   delete(UserModel user) async {
//     await userCollection.remove(where.eq('email', user.email));
//   }



// }