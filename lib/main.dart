import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_app_new/CreateProfile.dart';
import 'package:temp_app_new/profilephoto.dart';
import 'package:temp_app_new/registration.dart';
import 'package:temp_app_new/signin.dart';

import 'SelectJobs.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs=await SharedPreferences.getInstance();
  runApp( MyApp(/*token:prefs.getString('token')*/));
}

class MyApp extends StatelessWidget {
  // final token;
   const MyApp({
   // @required this.token,
    Key?key,
}):super(key:key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        // primaryColor: Colors.blue,
      ),
      home:LoginScreen(),
      debugShowCheckedModeBanner: false,
      // (JwtDecoder.isExpired(token)==false)?CreateProfile(token: token):LoginScreen(),
    );
  }
}

