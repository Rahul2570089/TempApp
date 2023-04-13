import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:temp_app_new/CreateProfile.dart';

class ProfilePhoto extends StatefulWidget {
  final token;
  const ProfilePhoto( {Key? key,@required this.token}) : super(key: key);

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  // late String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    //  email=jwtDecodedToken['email'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
    padding: const EdgeInsets.symmetric(horizontal:20,vertical:20),
    child: ListView(
    children: <Widget>[
    nameTextFormField(),
    SizedBox(
    height:20,
    ),
    professionTextFormField(),
    SizedBox(
    height:20,
    ),
    dobField(),
    SizedBox(
    height:20,
    ),
    PhoneField(),
    SizedBox(
    height:20,
    ),
    addressFormField(),
    ],
    ),
    ),






      // body:button(),
      // body:Column(
      //   mainAxisAlignment:MainAxisAlignment.center,
      //   children: [
      //     Text(email),
      //   ],
      // )
    );
  }

  Widget nameTextFormField(){
    return TextFormField(
      decoration:InputDecoration(
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
      decoration:InputDecoration(
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
      decoration:InputDecoration(
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
      decoration:InputDecoration(
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
      maxLines: 3,
      decoration:InputDecoration(
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

  // Widget button() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal:70),
  //     child: Column(
  //       mainAxisAlignment:MainAxisAlignment.center,
  //       crossAxisAlignment:CrossAxisAlignment.center,
  //       children:<Widget>[
  //         Text("Tap to button to add profile data",
  //           textAlign:TextAlign.center,
  //           style:TextStyle(
  //             color:Colors.deepOrange,
  //             fontSize:18,
  //           ),
  //         ),
  //         SizedBox(height:30),
  //         InkWell(
  //           onTap:()=>{
  //             Navigator.push(context,MaterialPageRoute(builder:(context)=>CreateProfile()))
  //           },
  //           child: Container(
  //               height:60,
  //               width:150,
  //               decoration:BoxDecoration(
  //                 color:Colors.blueGrey,
  //                 borderRadius:BorderRadius.circular(20),
  //               ),
  //               child:Center(
  //                   child:Text("Add Profile",style:TextStyle(
  //                     color:Colors.white,
  //                     fontSize:18,
  //                   ),)
  //               )
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }


}
