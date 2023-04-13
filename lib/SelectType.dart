import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:temp_app_new/SelectJobs.dart';
import 'CreateRecruiterProfile.dart';
import 'config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class SelectType extends StatefulWidget {
  final token;
  const SelectType({Key? key, this.token}) : super(key: key);

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {


  late String userId;


  @override
  void initState(){
    super.initState();
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    userId=jwtDecodedToken['_id'];
    // var token=jwtDecodedToken['_token'];
  }
  // get token => token;

  void sendJobType(String type) async {
    try {

      var regBody={
        'userId': userId,
        'type':[type]
      };

      var response=await http.post(Uri.parse(AddJobType),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(regBody)
      );
      var jsonResponse=jsonDecode(response.body);

      print(jsonResponse['status']);
      if(jsonResponse['status'])
      {
        if(type=='freelancer'){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>SelectJobs(token:widget.token)));
        }
        if(type=='recruiter'){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>CreateRecruiterProfile(token:widget.token)));
        }
        print("JobType stored successfully");
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

      }else{
        print("JobType not stored successfully");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.fromLTRB(8,100, 8, 8),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'What you are looking for ?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        sendJobType("freelancer");
                      },
                      icon: Icon(Icons.work),
                      label: Text('I want a job'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        sendJobType("recruiter");
                      },
                      icon: Icon(Icons.person),
                      label: Text('I want Job Seekers'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
