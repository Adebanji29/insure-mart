// //import 'package:sqflite/sqlite_api.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'dart:io'as io;

// import '../models/user_model.dart';

// class DBhelper{
//   Database ? _db;
  
//   final DB_Name = "insuremartDB";
//   final String Table_user = "users";
//   final int Version = 1;

//   final String C_title = "title";
//   final String C_firstname = "firstname";
//   final String C_lastname = "lastname";
//   final String C_email = "email";
//   final String C_password = "password";
  
//   Future<Database?> get db async{
//    // return _db;
//     if (_db != null) {
//       return _db;
//     }
// // lazily instantiate the db the first time it is accessed
//     _db = await initDB();

//     return _db;
//   }

//   initDB() async{

//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, DB_Name);
    
//     var db = await openDatabase(path, version: Version, onCreate: _onCreate);

//     return db;
//   }

//   _onCreate(Database db, int version ) async {
//     await db.execute("CREATE TABLE $Table_user ($C_email  TEXT PRIMARY KEY, $C_firstname TEXT,  $C_lastname TEXT, $C_password TEXT, $C_title TEXT)");
//   }

//   Future<UserModel> SignUpData (UserModel user ) async{
//     var dbClient = await db;
//     await dbClient?.insert(
//       Table_user,
//       user.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     //var dbClient = await db;
//     //user.email = (await dbClient.insert(Table_user, user.toMap())) as String;

//     return user;

//   }

//   Future<UserModel?> getLoginUser(String username, String password) async{
//     var dbClient = await db;
//     var res = await dbClient!.rawQuery("SELECT *  FROM $Table_user WHERE $C_email ='$username' AND $C_password = '$password'");
//     if(res.isNotEmpty){
//       return UserModel.fromMap(res.first);

//     }
//     return null;
//   }

// }