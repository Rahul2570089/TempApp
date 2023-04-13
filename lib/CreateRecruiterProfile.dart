import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_app_new/CreateProfile.dart';
import 'package:temp_app_new/RecruiterProfile.dart';
import 'package:temp_app_new/SelectJobs.dart';
import 'package:temp_app_new/config.dart';
import 'package:http/http.dart' as http;
import 'package:temp_app_new/profilephoto.dart';
import 'package:temp_app_new/registration.dart';

import 'SelectType.dart';

class CreateRecruiterProfile extends StatefulWidget {
  final token;
  const CreateRecruiterProfile({Key? key, this.token}) : super(key: key);

  @override

  State<CreateRecruiterProfile> createState() => _CreateRecruiterProfileState();
}

class _CreateRecruiterProfileState extends State<CreateRecruiterProfile> {
  late String userId;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController describeController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  // final AuthService authService = AuthService();
  bool _isNotValidate=false;
  // late SharedPreferences prefs;

  @override
  void initState()
  {
    super.initState();
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    userId=jwtDecodedToken['_id'];
    // initSharedPref();
  }

  void addCreateRecruiterProfile() async{
    var regBody={
      "userId":userId,
      "name":nameController.text,
      "description":describeController.text,
      "contact":contactController.text,
      "address":addressController.text
    };

    var response=await http.post(Uri.parse(AddRecruiterProfile),
        headers:{"Content-Type":"application/json"},
        body:jsonEncode(regBody)
    );
    var jsonResponse=jsonDecode(response.body);

    print(jsonResponse['status']);
    if(jsonResponse['status'])
    {
      print("RecruiterProfile stored successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        print(widget.token);
        return RecruiterProfile(token: widget.token);

      }));
      // Navigator.push(context,MaterialPageRoute(builder:(context)=>RecruiterProfile(token:widget.token)));
      // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

    }else{
      print("RecruiterProfile not stored successfully");
    }
  }

  // void loginUser() async{
  //
  //   if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
  //   {
  //     var reqBody={
  //       "email":emailController.text,
  //       "password":passwordController.text
  //     };
  //
  //     var response=await http.post(Uri.parse(login),
  //         headers:{"Content-Type":"application/json"},
  //         body:jsonEncode(reqBody)
  //     );
  //
  //     var jsonResponse=jsonDecode(response.body);
  //     if(jsonResponse['status']){
  //       var myToken=jsonResponse['token'];
  //       prefs.setString('token', myToken);
  //       Navigator.push(context,MaterialPageRoute(builder:(context)=>SelectType(token:myToken)));
  //     }else{
  //       print('Something went wrong');
  //     }
  //   }
  //
  //
  //
  //   // authService.signInUser(
  //   //   context: context,
  //   //   email: emailController.text,
  //   //   password: passwordController.text,
  //   // );
  // }

  @override
  bool _obscureText = true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Fill Profile Information",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:TextField(
              cursorColor: Colors.black,
              controller: nameController,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black), // set border color
                ),
                filled:true,
                hintStyle: TextStyle(color: Colors.black),
                errorStyle:TextStyle(color:Colors.red),
                errorText:_isNotValidate?"Enter proper Info":null,
                hintText: "Enter your name/company's name",

              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              cursorColor: Colors.black,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              controller: describeController,
              // keyboardType:TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black), // set border color
                ),
                filled:true,
                errorStyle:TextStyle(color:Colors.red),

                errorText:_isNotValidate?"Enter proper Info":null,
                hintText: 'Describe your profession',
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),

          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              cursorColor: Colors.black,
              controller: contactController,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled:true,
                errorStyle:TextStyle(color:Colors.red),
                errorText:_isNotValidate?"Enter proper Info":null,
                hintText: 'Enter contact number',
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
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
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              controller: addressController,
              // keyboardType:TextInputType.text,
              decoration: InputDecoration(
                filled:true,
                fillColor: Colors.grey[300],
                errorStyle:TextStyle(color:Colors.red),
                errorText:_isNotValidate?"Enter proper Info":null,
                hintText: 'Enter address',
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
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed:(){

              addCreateRecruiterProfile();


              // loginUser();

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
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

        ],
      ),
    );
  }
}
