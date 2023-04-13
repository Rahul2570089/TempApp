import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

import 'ReviewScreen.dart';
import 'config.dart';
class DisplayAllRequests extends StatefulWidget {
  final token;
  const DisplayAllRequests({Key? key, this.token}) : super(key: key);

  @override
  State<DisplayAllRequests> createState() => _DisplayAllRequestsState();
}

class _DisplayAllRequestsState extends State<DisplayAllRequests> {
  late String userId;
  List? items;
  List? findId ;
  List? userName;
  @override
  void initState(){
    super.initState();
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);

    userId=jwtDecodedToken['_id'];
    getAllRequests(userId);
  }


  Future<void> getAllRequests(userId) async{
    var regBody = {"userId": userId};
    var response = await http.post(Uri.parse(displayAllRequests),
      headers:{"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      var successList = jsonResponse['success']['success'];
      findId = successList.map((item) => item['findId']).toList();
      userName = successList.map((item) => item['userName']).toList();
    } else {
      // handle error
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: findId == null
                    ? null
                    : SingleChildScrollView(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: findId!.length,
                    itemBuilder: (context, int index) {
                      var id = findId![index]['id'];
                      var name = findId![index]['name'];
                      var userNameItem = userName![index];
                      return Card(
                        borderOnForeground: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${userNameItem}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text('$id'),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ReviewScreen(userId, '${findId![index]['userId']}'),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.black54),
                                    textStyle: MaterialStateProperty.all(
                                      const TextStyle(color: Colors.white),
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(
                                        MediaQuery.of(context).size.width / 4.5,
                                        40,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Hire",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => TypeScreen()),
                                    // );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.black54),
                                    textStyle: MaterialStateProperty.all(
                                      const TextStyle(color: Colors.white),
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(
                                        MediaQuery.of(context).size.width / 4.5,
                                        40,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Reject",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }










}
