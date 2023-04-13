import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_app_new/CreateProfile.dart';
import 'package:temp_app_new/RecruiterProfile.dart';
import 'package:temp_app_new/SelectJobs.dart';
import 'package:temp_app_new/config.dart';
import 'package:http/http.dart' as http;
import 'package:temp_app_new/profilephoto.dart';
import 'package:temp_app_new/registration.dart';

import 'SelectType.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final AuthService authService = AuthService();
bool _isNotValidate=false;
late SharedPreferences prefs;

void initState()
{
  super.initState();
  initSharedPref();
}

void initSharedPref() async{
  prefs=await SharedPreferences.getInstance();
}

  void loginUser() async{

    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
      {
        var reqBody={
          "email":emailController.text,
          "password":passwordController.text
        };

        var response=await http.post(Uri.parse(login),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(reqBody)
        );
        
        var jsonResponse=jsonDecode(response.body);
        if(jsonResponse['status']){
          var myToken=jsonResponse['token'];
          prefs.setString('token', myToken);
          Navigator.push(context,MaterialPageRoute(builder:(context)=>SelectType(token:myToken)));
          // Navigator.push(context,MaterialPageRoute(builder:(context)=>RecruiterProfile(token:myToken)));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(jsonResponse['message']),
              backgroundColor: Colors.black,
            ),
          );
          // print('Something went wrong');
        }
      }



    // authService.signInUser(
    //   context: context,
    //   email: emailController.text,
    //   password: passwordController.text,
    // );
  }

  @override
  bool _obscureText = true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:TextField(
              cursorColor: Colors.black,
              controller: emailController,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                filled:true,
                fillColor: Colors.grey[300],
                errorStyle:TextStyle(color:Colors.red),
                errorText:_isNotValidate?"Enter proper Info":null,
                hintText: 'Enter your Email',
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black), // set border color
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              cursorColor: Colors.black,
              controller: passwordController,
              obscureText: _obscureText,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                filled:true,
                fillColor: Colors.grey[300],
                errorStyle:TextStyle(color:Colors.red),
                errorText:_isNotValidate?"Enter proper Info":null,
                hintText: 'Enter your Password',
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black), // set border color
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText; // toggle password obscuration on tap
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility, // change icon based on password obscuration
                    color: Colors.black,
                  ),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed:(){
              loginUser();

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => TypeScreen()),
              // );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black54),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Text("Don't have an account? ",style: TextStyle(color: Colors.blueGrey)),
               InkWell(
                  child: new Text('Click here ',style: TextStyle(color: Colors.black54,fontWeight:FontWeight.bold),),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  }
              ),
              Text("to register.",style: TextStyle(color: Colors.blueGrey))
            ],
          ),

        ],
      ),
    );
  }
}
