import 'dart:io';
import 'dart:convert';
import 'dart:html';



import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'WeeklyHours.dart';
import 'config.dart';
import 'google_map.dart';

class JobSeekerProfilePage extends StatefulWidget {
  final token;
  JobSeekerProfilePage({Key? key, this.token}) : super(key: key);

  @override
  State<JobSeekerProfilePage> createState() => _JobSeekerProfilePageState();
}

class _JobSeekerProfilePageState extends State<JobSeekerProfilePage> {
  get token => widget.token;
  late String userId;
  int _selectedIndex = 0;
  FileImage? _image;
  String name='';
  String Rate='';
  late final TextEditingController controller;
  late final TextEditingController rateController;



  Future<void> _getImage(ImageSource source) async {
    // final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: source);
    //
    // if (pickedFile != null) {
    //   setState(() {
    //     _image = ImageFile(pickedFile.path as List<Object>);
    //   });
    // }
    print(_image.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller= TextEditingController();
    rateController=TextEditingController();
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    userId=jwtDecodedToken['_id'];
    if (widget.token != null) {
      // getRecruiterProfile(userId);
    }
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
                      imageProfile(),
                      // Spacer(),
                      SizedBox(width:30),
                      Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        crossAxisAlignment:CrossAxisAlignment.center,
                        children: [
                          Text("Bhavya", style: TextStyle(fontWeight: FontWeight.bold,fontSize:26),),
                          Row(
                            children: [
                              Text(name),
                            ],
                          ),
                          const SizedBox(height:16),
                          ElevatedButton(onPressed: ()async{
                            final name=await openDialog();
                            if(name==null || name.isEmpty)return;
                            // setState(()=>this.name=name);
                            setState(() {
                              this.name=name;
                              // addProfession(name);
                              postProfileProfession(name);
                            });
                          }, child:Text('Add Profession'))

                        ],
                      ),
                      SizedBox(height:50),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        child:Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children: [
                            Text("5.0"),
                            Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              crossAxisAlignment:CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.star,size:12,),
                                Icon(Icons.star,size:12,),
                                Icon(Icons.star,size:12,),
                                Icon(Icons.star,size:12,),
                                Icon(Icons.star,size:12,),
                              ],
                            ),
                            Text("Rating"),
                          ],
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: ()async{
                          final Rate=await openDialog2();
                          if(Rate==null || Rate.isEmpty)return;
                          // setState(()=>this.Rate=Rate!);
                          setState(() {
                            this.Rate=Rate;
                            // addMinRate(Rate);
                            postProfileRate(Rate);
                          });


                        },
                        child: Container(
                          child:Column(
                            mainAxisAlignment:MainAxisAlignment.center,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: [

                              Rate==''?Text("Not Set"): Row(
                                children: [
                                  Text(Rate),

                                  Icon(Icons.currency_rupee,size:12,),
                                ],
                              ),
                              SizedBox(
                                height:10,
                              ),

                              Text("Min.Rate"),

                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child:Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children: [
                            Text("-"),
                            Icon(Icons.monetization_on_rounded,size:12,),
                            Text("Earnings"),
                          ],
                        ),
                      ),
                      Spacer()
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
                            subtitle: Text('Location,no. of hours'),
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
                          leading: Icon(Icons.account_box),
                          title: Text('Skills & Experiences'),
                          subtitle: Text('Experience'),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('My Settings'),
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
                          subtitle: Text('Aadhar Card'),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.rate_review),
                          title: Text('Reviews'),
                          subtitle: Text('My Review'),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical:20),
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap:(){
                      Navigator.push(context,MaterialPageRoute(builder:(context)=>GoogleMap(token:token)));
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        border:Border.all(width:0.1,color:Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:20,bottom:20),
                        child: Row(
                          children: [
                            Icon(Icons.location_pin),
                            SizedBox(width:10,),
                            Text("Location"),
                            Spacer(),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Navigator.push(context,MaterialPageRoute(builder:(context)=>WeeklyHours(token:token)));
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        border:Border.all(width:0.1,color:Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:20,bottom:20),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month),
                            SizedBox(width:10,),
                            Text("Weekly hours"),
                            Spacer(),
                            Icon(Icons.chevron_right),

                          ],
                        ),
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


  Widget imageProfile(){
    return Center(
      child: Stack(
        children:<Widget> [
          CircleAvatar(
            radius:80.0,
             backgroundImage:
             _image == null?
                 const AssetImage("assets/grey_image.jpg")
                : Image(image:_image!) as ImageProvider<Object>,
          ),
          Positioned(
            bottom:20.0,
            right:20.0,
            child:InkWell (
                onTap:(){

                  showModalBottomSheet(context: context, builder: ((builder)=>bottomSheet()),
                  );
                },
                child:Icon(
                  Icons.camera_alt,
                  color:Colors.black,
                  size:28.0,
                )
            ),
          )
        ],
      ),
    );
  }


}
