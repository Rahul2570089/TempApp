import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'config.dart';
class ProfilePage extends StatefulWidget {
  final token;
  const ProfilePage({Key? key, this.token}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userId;
  int _selectedIndex = 0;
  List? item;
  String name='';

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    userId=jwtDecodedToken['_id'];
    if (widget.token != null) {
      getRecruiterProfile(userId);
    }
}

  void getRecruiterProfile(userId) async {
    try {

      var regBody={
        "userId":userId,
      };

      var response=await http.post(Uri.parse(GetRecruiterProfile),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(regBody)
      );
      var jsonResponse=jsonDecode(response.body);
      item=jsonResponse['success'];

      setState(() {


      });

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

  // File? _image;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Visibility(
            visible:_selectedIndex==0,
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical:20),
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                      // imageProfile(),
                      // Spacer(),
                      SizedBox(width:30),
                      Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        crossAxisAlignment:CrossAxisAlignment.center,
                        children: [
                          Text('${item![0]['name']}', style: TextStyle(fontWeight: FontWeight.bold,fontSize:36),),
                          Row(
                            children: [
                              Text(name),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(height:50),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [

                      Container(
                        child:Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children: [
                            Text("07",style:(TextStyle(fontSize:36,fontWeight:FontWeight.bold)),),
                            Text("Total Job Posts"),
                          ],
                        ),
                      ),
                      // Spacer()
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        _selectedIndex=1;
                      });
                    },
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.tune),
                            title: Text('Work Preferences'),
                            subtitle: Text('about,contact no.,address'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          subtitle: Text('Policy, Logout, Bank details'),
                        ),
                      ],
                    ),
                  ),


                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.document_scanner),
                          title: Text('My Documents'),
                          subtitle: Text('Company Registration Certificate'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible:_selectedIndex==1,
            child:

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical:20),
              child: Column(
                children: <Widget>[

                  Container(
                    decoration:BoxDecoration(
                      border:Border.all(width:0.1,color:Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:20,bottom:20),
                      child: Row(
                        children: [
                          SizedBox(width:10,),
                          Text("Address:",style: TextStyle(fontWeight: FontWeight.bold,fontSize:16)),
                          Text('${item![0]['address']}'),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    decoration:BoxDecoration(
                      border:Border.all(width:0.1,color:Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:20,bottom:20),
                      child: Row(
                        children: [
                          SizedBox(width:10,),
                          Text("contact no:",style: TextStyle(fontWeight: FontWeight.bold,fontSize:16)),
                          Text('${item![0]['contact']}'),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    decoration:BoxDecoration(
                      border:Border.all(width:0.1,color:Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:20,bottom:20),
                      child: Row(
                        children: [
                          SizedBox(width:10,),
                          Text("description:",style: TextStyle(fontWeight: FontWeight.bold,fontSize:16)),
                          Text('${item![0]['description']}'),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )

        ]
    );
  }

  // Widget imageProfile(){
  //   return Center(
  //     child: Stack(
  //       children:<Widget> [
  //         CircleAvatar(
  //           radius:80.0,
  //           backgroundImage: _image == null
  //               ? AssetImage("assets/mountain.jpeg")
  //               : FileImage(_image! as File) as ImageProvider<Object>,
  //         ),
  //         Positioned(
  //           bottom:20.0,
  //           right:20.0,
  //           child:InkWell (
  //               onTap:(){
  //
  //                 showModalBottomSheet(context: context, builder: ((builder)=>bottomSheet()),
  //                 );
  //               },
  //               child:Icon(
  //                 Icons.camera_alt,
  //                 color:Colors.blue,
  //                 size:28.0,
  //               )
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

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
              " Your logo or profile",
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
                  // _getImage(ImageSource.camera);
                }, icon:Icon(Icons.camera), label: Text("Camera")),
                ElevatedButton.icon(onPressed: (){
                  // _getImage(ImageSource.gallery);
                }, icon:Icon(Icons.image), label: Text("Gallery"))
              ],
            )
          ],
        )
    );
  }

  // Future<void> _getImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: source);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path as List<Object>);
  //     });
  //   }
  //   print(_image.toString());
  // }
}
