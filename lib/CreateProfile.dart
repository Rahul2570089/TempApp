import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:temp_app_new/google_map.dart';
import 'package:temp_app_new/signin.dart';

import 'DisplayJobSeekerJobs.dart';
import 'JobSeekerProfilePage.dart';
import 'WeeklyHours.dart';
import 'config.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  final token;
  const CreateProfile({Key? key,this.token}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  late List<Widget> screens;
  int _selectedIndex = 0;
  File? _image;

  get token => widget.token;

  int currentIndex =2;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    print(_image.toString());
  }
  // late final PickedFile _imageFile;
  // final ImagePicker _picker=ImagePicker();
  late String userId;
  late final TextEditingController controller;
  late final TextEditingController rateController;
  String Rate='';
  String name='';
  final TextEditingController _profileName = TextEditingController();
  final TextEditingController _profileProfession = TextEditingController();
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

  // void addProfession(String Name) async{
  //
  //
  //       var regBody={
  //         "userId":userId,
  //         "profession":Name,
  //       };
  //
  //       var response=await http.post(Uri.parse(AddProfession),
  //           headers:{"Content-Type":"application/json"},
  //           body:jsonEncode(regBody)
  //       );
  //       var jsonResponse=jsonDecode(response.body);
  //
  //       print(jsonResponse['status']);
  //       if(jsonResponse['status'])
  //       {
  //         print("Profession stored successfully");
  //         // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
  //
  //       }else{
  //
  //       }
  //     }

  // void addMinRate(String MinRate) async{
  //
  //
  //   var regBody={
  //   //     "userId":userId,
  //   //     "minrate":MinRate,
  //   //   };
  //   //
  //   //   var response=await http.post(Uri.parse(AddMinRate),
  //   //       headers:{"Content-Type":"application/json"},
  //   //       body:jsonEncode(regBody)
  //   //   );
  //   //   var jsonResponse=jsonDecode(response.body);
  //   //
  //   //   print(jsonResponse['status']);
  //   //   if(jsonResponse['status'])
  //   //   {
  //   //     print("MinRate stored successfully");
  //     // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
  //
  //   }else{
  //     print("MinRate not stored successfully");
  //   }
  // }








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




      // var url = Uri.parse('http://localhost:3000/storeProfile/profession');
      // var response = await http.post(url, body: {
      //   'userId': userId,
      //   'profession': profession,
      // });
    //   print(response.body);
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




      // var url = Uri.parse('http://localhost:3000/storeProfile/profession');
      // var response = await http.post(url, body: {
      //   'userId': userId,
      //   'profession': profession,
      // });
      //   print(response.body);
    } catch (error) {
      print('Error: $error');
    }
  }


  @override
  Widget build(BuildContext context) {

    screens = [

      DisplayJobSeekerJobs(token:widget.token),
      // Center(child: Text('My Jobs', style: TextStyle(fontSize: 60))),
      // DisplayAllJobs(token:widget.token,),
      // NewJobPosting(token:widget.token,),
      Center(child: Text('fff', style: TextStyle(fontSize: 60))),
      JobSeekerProfilePage(token:widget.token),
      // ProfilePage(token: widget.token)
    ];
  
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar:AppBar(
        backgroundColor: Colors.black54,
        title:Text("Your Profile"),
        centerTitle:true,
      ),
      body:screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor:Colors.black,

        items: [


          BottomNavigationBarItem(
            icon: Icon(Icons.search,color:Colors.grey,),
            label: 'Find Jobs',
          ),
          BottomNavigationBarItem(

            icon: Icon( Icons.calendar_month_sharp,color:Colors.grey,),
            label: 'Booked Jobs',
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

  Widget bottomSheet(){
  return Container(
    height:100.0,
    width:MediaQuery.of(context).size.width,
    margin:EdgeInsets.symmetric(
      horizontal:20,
      vertical:20,
    ),
    child:Column(
      children:<Widget>[
        Text(
          "Choose Profile photo",
          style:TextStyle(
            fontSize:20.0,
          ),
        ),
        SizedBox(
          height:20,
        ),
        Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget> [
           ElevatedButton.icon(onPressed: (){
             _getImage(ImageSource.camera);
           }, icon:Icon(Icons.camera), label: Text("Camera")),
            ElevatedButton.icon(onPressed: (){
              _getImage(ImageSource.gallery);
            }, icon:Icon(Icons.image), label: Text("Gallery"))
          ],
        )
      ],
    )
  );
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


  Widget professionTextFormField(){
    return TextFormField(
      controller:_profileProfession,
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
        labelText:"Profession",
        hintText:"Full Stack",
        helperText:"Profession can't be empty",
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
