import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:temp_app_new/PersonFeed.dart';
import 'package:temp_app_new/ProfilePage.dart';
import 'package:temp_app_new/google_map.dart';
import 'package:temp_app_new/signin.dart';

import 'DisplayAllJobs.dart';
import 'DisplayAllRequests.dart';
import 'NewJobPosting.dart';
import 'WeeklyHours.dart';
import 'config.dart';
import 'package:image_picker/image_picker.dart';

class RecruiterProfile extends StatefulWidget {
  final String token;
  RecruiterProfile({Key? key,required this.token}) : super(key: key);

  @override
  State<RecruiterProfile> createState() => _RecruiterProfileState();
}

class _RecruiterProfileState extends State<RecruiterProfile> {
  late List<Widget> screens;
  int currentIndex=3;
  late String userId;
  // late final PickedFile _imageFile;
  // final ImagePicker _picker=ImagePicker();
  late final TextEditingController controller;
  late final TextEditingController rateController;
  String Rate='';

  final TextEditingController _profileName = TextEditingController();
  // final TextEditingController _profileProfession = TextEditingController();
  final TextEditingController _profileDOB = TextEditingController();
  final TextEditingController _profilePhone = TextEditingController();
  final TextEditingController _profileAddress= TextEditingController();
  bool _isNotValidate=false;


  void initState(){
    super.initState();
    // _imageFile = PickedFile('');
    controller= TextEditingController();
    rateController=TextEditingController();
    // var token=widget.token;
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    userId=jwtDecodedToken['_id'];





    // getRecruiterProfile(userId);
  }

  void insertProfile() async{
    // if(_profileName.text.isNotEmpty && _profileProfession.text.isNotEmpty && _profileDOB.text.isNotEmpty && _profilePhone.text.isNotEmpty && _profileAddress.text.isNotEmpty)
    // {
    //   var regBody={
    //     "userId":userId,
    //     "name":_profileName.text,
    //     "profession":_profileProfession.text,
    //     "DOB":_profileDOB.text,
    //     "phone":_profilePhone.text,
    //     "address":_profileAddress.text
    //   };
    //
    //   var response=await http.post(Uri.parse(addProfile),
    //       headers:{"Content-Type":"application/json"},
    //       body:jsonEncode(regBody)
    //   );
    //   var jsonResponse=jsonDecode(response.body);
    //
    //   print(jsonResponse['status']);
    //   if(jsonResponse['status'])
    //   {
    //     // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
    //
    //   }else{
    //
    //   }
    // }else{
    //   setState(() {
    //     _isNotValidate=true;
    //   });
    // }

    //--------------------------------------------------------------------------------------------
    // authService.signUpUser(
    //   context: context,
    //   email: emailController.text,
    //   password: passwordController.text,
    //   name: nameController.text,
    // );
  }


  Future<void> postProfileProfession(String profession) async {
    try {

      var regBody={
        "userId":userId,
        "profession":profession,
      };

      var response=await http.post(Uri.parse(AddProfession),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(regBody)
      );
      var jsonResponse=jsonDecode(response.body);

      print(jsonResponse['status']);
      if(jsonResponse['status'])
      {
        print("Profession stored successfully");
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

      }else{
        print("Profession not stored successfully");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> postProfileRate(String rate) async {
    try {

      var regBody={
        "userId":userId,
        "rate":rate,
      };

      var response=await http.post(Uri.parse(AddRate),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(regBody)
      );
      var jsonResponse=jsonDecode(response.body);

      print(jsonResponse['status']);
      if(jsonResponse['status'])
      {
        print("MinRate stored successfully");
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

      }else{
        print("MinRate not stored successfully");
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    screens = [
      // Center(child: Text('Feed', style: TextStyle(fontSize: 60))),
      DisplayAllRequests(token:widget.token,),
      // Center(child: Text('My Jobs', style: TextStyle(fontSize: 60))),
      DisplayAllJobs(token:widget.token,),
      NewJobPosting(token:widget.token,),
      // Center(child: Text('fff', style: TextStyle(fontSize: 60))),
      ProfilePage(token: widget.token)
    ];
    return Scaffold(
      appBar:AppBar(
        title:Text("TemApp"),
        centerTitle:true,
      ),
      body:screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor:Colors.black,
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed,color:Colors.grey,),
            label: 'Hire',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_sharp,color:Colors.grey,),
            label: 'My Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add,color:Colors.grey,),
            label: 'New Job',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color:Colors.grey,),
            label: 'Profile',
          ),
        ],
    onTap:(index)=>setState(()=>currentIndex=index),
      ),
    );
  }

  Future<String?> openDialog2()=>showDialog<String>(context: context, builder:(context)=>AlertDialog(
    title:Text("Enter Minimum Rate"),
    content:TextField(
      autofocus: true,
      decoration:InputDecoration(hintText:"Add your min. rate"),
      controller:rateController,
    ),
    actions: [
      TextButton(onPressed:submit2, child:Text("SUBMIT")),
    ],
  ));

  void submit2()
  {
    Navigator.of(context).pop(rateController.text);
  }

  Future<String?> openDialog()=>showDialog<String>(context: context, builder:(context)=>AlertDialog(
    title:Text("Add Profession"),
    content:TextField(
      autofocus: true,
      decoration:InputDecoration(hintText:"Add a short professional summary"),
      controller:controller,
    ),
    actions: [
      TextButton(onPressed:submit, child:Text("SUBMIT")),
    ],
  ));

  void submit()
  {
    Navigator.of(context).pop(controller.text);
  }





  Widget nameTextFormField(){
    return TextFormField(
      controller:_profileName,
      decoration:InputDecoration(
        errorText:_isNotValidate?"Enter proper Info":null,
        border:OutlineInputBorder(
            borderSide:BorderSide(
              color:Colors.teal,
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderSide:BorderSide(
              color:Colors.blue,
              width:2,
            )
        ),
        prefixIcon:Icon(Icons.person,
          color:Colors.blue,

        ),
        labelText:"Name",
        hintText:"Dev Stack",
        helperText:"Name can't be empty",
      ),
    );
  }


  Widget dobField(){
    return TextFormField(
      controller:_profileDOB,
      decoration:InputDecoration(
        errorText:_isNotValidate?"Enter proper Info":null,
        border:OutlineInputBorder(
            borderSide:BorderSide(
              color:Colors.teal,
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderSide:BorderSide(
              color:Colors.blue,
              width:2,
            )
        ),
        prefixIcon:Icon(Icons.person,
          color:Colors.blue,

        ),
        labelText:"Date of Birth",
        hintText:"Provide DOB on dd/mm/yyyy",
        helperText:"01/01/2020",
      ),
    );
  }

  Widget PhoneField(){
    return TextFormField(
      controller:_profilePhone,
      decoration:InputDecoration(
        errorText:_isNotValidate?"Enter proper Info":null,
        border:OutlineInputBorder(
            borderSide:BorderSide(
              color:Colors.teal,
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderSide:BorderSide(
              color:Colors.blue,
              width:2,
            )
        ),
        prefixIcon:Icon(Icons.person,
          color:Colors.blue,

        ),
        labelText:"phone number",
        hintText:"+919484606546",
        helperText:"Phone no. can't be empty",
      ),
    );
  }

  Widget addressFormField(){
    return TextFormField(
      controller:_profileAddress,
      maxLines: 3,
      decoration:InputDecoration(
        errorText:_isNotValidate?"Enter proper Info":null,
        border:OutlineInputBorder(
            borderSide:BorderSide(
              color:Colors.teal,
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderSide:BorderSide(
              color:Colors.blue,
              width:2,
            )
        ),

        labelText:"Address",
        hintText:"Write address",

      ),
    );
  }




}
