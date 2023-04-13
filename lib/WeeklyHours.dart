import 'dart:convert';
import 'config.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class WeeklyHours extends StatefulWidget {
  final token;
  const WeeklyHours({Key? key, this.token}) : super(key: key);

  @override
  State<WeeklyHours> createState() => _WeeklyHoursState();
}

class _WeeklyHoursState extends State<WeeklyHours> {
  late String userId;
  int? _value = 1;
  late String labelValue;
  List<String> labels = ['0-10', '10-20', '20-30','30-40','40+'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    userId=jwtDecodedToken['_id'];
    labelValue='10-20';
  }

  Future<void> postProfileHours(String labelValue) async {
    try {

      var regBody={
        "userId":userId,
        "lablehours":labelValue,
      };

      var response=await http.post(Uri.parse(AddHours),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(regBody)
      );
      var jsonResponse=jsonDecode(response.body);

      print(jsonResponse['status']);
      if(jsonResponse['status'])
      {
        print("LableHours stored successfully");
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

      }else{
        print("LableHours not stored successfully");
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
    return Scaffold(
      body:Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("How many hours a week do you want to work?",  style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            Text('Choose an item'),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 5.0,
              children:List<Widget>.generate(
                labels.length,
                    (int index) {
                  return ChoiceChip(
                    label: Text(labels[index]),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                        labelValue=labels[index];
                      });
                    },
                  );
                },
              ).toList()
            ),
            SizedBox(
              height:30,
            ),
            ElevatedButton(
              onPressed:(){},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width / 2.5, 50),
                ),
              ),
              child:InkWell(
                onTap:(){
                  setState(() {
                    postProfileHours('20-30');
                  });

                },
                child: const Text(
                  "submit",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
