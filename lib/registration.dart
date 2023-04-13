import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:temp_app_new/signin.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class RegistrationScreen extends StatefulWidget {
  const  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State< RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool _isNotValidate=false;
  // final AuthService authService = AuthService();

  String? _validateName(String? value) {
    if (value == null ||value.isEmpty) {
      return '';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null ||value.isEmpty) {
      return '';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
      return 'Password must contain at least 8 characters, including at least one uppercase letter, one lowercase letter, one number, and one special character';
    }
     return null;
  }

  String? _validateEmail(String? value) {
    if (value == null ||value.isEmpty) {
      return '';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
  void signupUser() async{
 if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty && nameController.text.isNotEmpty)
{
   var regBody={
     "name":nameController.text.isNotEmpty,
     "email":emailController.text,
     "password":passwordController.text
   };

   var response=await http.post(Uri.parse(registration),
    headers:{"Content-Type":"application/json"},
       body:jsonEncode(regBody)
   );
   var jsonResponse=jsonDecode(response.body);

   print(jsonResponse['status']);
if(jsonResponse['status'])
  {
    Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

  }else{

   final snackBar = SnackBar(
     content: Text('User with the same email id already exists'),
     duration: Duration(seconds: 2),
   );
   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}else{
   setState(() {
     _isNotValidate=true;
   });
 }
  }

  void _registerUser() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      signupUser();
      // call your registration function
    }
    else {
      // form is invalid, show snackbar
      final snackBar = SnackBar(
        content: const Text('Please fill out all fields'),
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _obscureText=true;
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Signup",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
      Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: nameController,
                    validator: _validateName,
                    keyboardType:TextInputType.text,
                    decoration: InputDecoration(
                      filled:true,
                      fillColor: Colors.grey[300],
                      errorStyle:TextStyle(color:Colors.blueGrey),
                      errorText:_isNotValidate?"Enter proper Info":null,
                      hintText: 'Enter your Name',
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
                Text(
                  _validateName(nameController.text) ?? '',
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ],
            ),

          const SizedBox(height: 20),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: _validateEmail,
                  cursorColor: Colors.black,
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(

                    filled: true,
                    fillColor: Colors.grey[300], // set the background color to grey
                    errorStyle: TextStyle(color: Colors.blueGrey),
                    errorText: _isNotValidate ? "Enter proper Info" : null,
                    hintText: 'Email',
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
                  style: TextStyle(color: Colors.black), // set text color to black
                ),
              ),
              Text(
                _validateName(emailController.text) ?? '',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextFormField(
                  validator: _validatePassword,
                  cursorColor: Colors.black,
                  controller: passwordController,
                  obscureText: _obscureText,
                  keyboardType:TextInputType.text,
                  decoration: InputDecoration(
                    filled:true,
                    fillColor: Colors.grey[300],
                    errorStyle:TextStyle(color:Colors.blueGrey),
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
                  ),
                  style: TextStyle(color: Colors.black),
                ),
            Row(
              children: [
                Flexible(
                      child: Text(
                        _validatePassword(passwordController.text) ?? '',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
              ],
            ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _registerUser,
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
              "Sign up",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(height:30),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: const Text('Login User?',style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      ),
    );
  }
}