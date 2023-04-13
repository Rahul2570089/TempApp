
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class DisplayJobSeekerJobs extends StatefulWidget {
  final token;
  const DisplayJobSeekerJobs({Key? key, this.token}) : super(key: key);

  @override
  State<DisplayJobSeekerJobs> createState() => _DisplayJobSeekerJobsState();
}

class _DisplayJobSeekerJobsState extends State<DisplayJobSeekerJobs> {
  List<bool> isAppliedList = [];
  late String userId;
  List? items;

  @override
  void initState(){
    super.initState();
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);

    userId=jwtDecodedToken['_id'];
    getAllJobs(userId);
  }


  Future<void> getAllJobs(userId) async{
    print(userId);
    var regBody={
      "userId":userId
    };

    var response=await http.post(Uri.parse(GetJobMatchingSeeker),
        headers:{"Content-Type":"application/json"},
        body:jsonEncode(regBody)
    );
    var jsonResponse=jsonDecode(response.body);
    print(response.body);
    items=jsonResponse['success'];
    isAppliedList = List.filled(items!.length, false);
    setState(() {

    });
  }
  void handleApply(int index) {
    setState(() {
      isAppliedList[index] = true;
    });
    StoreRequestSend('${items![index]['_id']}','${items![index]['type']}');
  }

  Future<void> StoreRequestSend(String id,String name) async{
    print(userId);
    var regBody={
      "userId":userId,
      "id":id,
      "name":name
    };

    var response=await http.post(Uri.parse(storeRequestSend),
        headers:{"Content-Type":"application/json"},
        body:jsonEncode(regBody)
    );
    var jsonResponse=jsonDecode(response.body);
    print(response.body);
    if(jsonResponse['status'])
    {
      print("RequestSend stored successfully");
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   print(widget.token);
      //   return RecruiterProfile(token: widget.token);
      //
      // }));
      // Navigator.push(context,MaterialPageRoute(builder:(context)=>RecruiterProfile(token:widget.token)));
      // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

    }else{
      print("RequestSend not stored successfully");
    }

    setState(() {

    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Expanded(child:Container(
          // height:300,
          decoration:BoxDecoration(
              color:Colors.white,
              borderRadius:BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20))
          ),
          child:Padding(
            padding:EdgeInsets.all(8.0),
            child:items==null?null:ListView.builder(
                itemCount:items!.length,
                itemBuilder: (context,int index){
                  return Card(
                    child:Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: [
                        Text('${items![index]['type']}',style:TextStyle(fontWeight:FontWeight.bold),),
                        Text('id:${items![index]['_id']}'),
                        SizedBox(height:10,),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment:MainAxisAlignment.center,
                              crossAxisAlignment:CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.monetization_on_outlined),
                                Text('${items![index]['price']}'),
                              ],
                            ),
                            SizedBox(width:20,),
                            Column(
                              mainAxisAlignment:MainAxisAlignment.center,
                              crossAxisAlignment:CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.date_range),
                                Text('${items![index]['date']}'),
                                Text('${items![index]['time']}'),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height:10,),
                        // ElevatedButton(
                        //   onPressed:(){
                        //
                        //      StoreRequestSend('${items![index]['_id']}','${items![index]['type']}');
                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(builder: (context) => TypeScreen()),
                        //     // );
                        //   },
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all(Colors.blue),
                        //     textStyle: MaterialStateProperty.all(
                        //       const TextStyle(color: Colors.white),
                        //     ),
                        //     minimumSize: MaterialStateProperty.all(
                        //       Size(MediaQuery.of(context).size.width / 4.5, 30),
                        //     ),
                        //   ),
                        //   child: const Text(
                        //     "Apply",
                        //     style: TextStyle(color: Colors.white, fontSize: 16),
                        //   ),
                        // ),
                    ElevatedButton(
                      onPressed: isAppliedList[index]
                          ? null
                          : () {
                        handleApply(index);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          isAppliedList[index] ? Colors.blueGrey : Colors.grey,
                        ),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.white),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width / 4.5, 30),
                        ),
                      ),
                      child: Text(
                        isAppliedList[index] ? "Applied" : "Apply",
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                        SizedBox(height:10,),
                      ],
                    ),
                                      );
                }),
          ),
        )),
      ],
    );
  }
}
