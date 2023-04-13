import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

import 'config.dart';
class DisplayAllJobs extends StatefulWidget {
  final token;
  const DisplayAllJobs({Key? key, this.token}) : super(key: key);

  @override
  State<DisplayAllJobs> createState() => _DisplayAllJobsState();
}

class _DisplayAllJobsState extends State<DisplayAllJobs> {
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

    var response=await http.post(Uri.parse(GetAllJobs),
        headers:{"Content-Type":"application/json"},
        body:jsonEncode(regBody)
    );
    var jsonResponse=jsonDecode(response.body);
    items=jsonResponse['success'];

    setState(() {

    });
  }

  void deleteItem(id)async{
    var regBody={
      "id":id
    };

    var response=await http.post(Uri.parse(DeleteJob),
        headers:{"Content-Type":"application/json"},
        body:jsonEncode(regBody)
    );
    var jsonResponse=jsonDecode(response.body);
   if(jsonResponse['status'])
     {
       getAllJobs(userId);
     }

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
                  return Slidable(
                    key:const ValueKey(0),
                   endActionPane:ActionPane(
                     motion:const ScrollMotion(),
                     dismissible:DismissiblePane(onDismissed:(){},),
                     children: [
                       SlidableAction(
                           backgroundColor:Color(0xFFFE4A49),
                           foregroundColor:Colors.white,
                           icon:Icons.delete,
                           label:'Delete',
                           onPressed:(BuildContext context){
                         print('${items![index]['_id']}');
                         deleteItem('${items![index]['_id']}');
                       },),
                     ],
                   ),
                    child:Card(
                      borderOnForeground:false,
                      child:ListTile(
                        leading:Icon(Icons.task),
                        title:Text('${items![index]['type']}'),
                        subtitle:Text('${items![index]['_id']}'),
                        trailing:Icon(Icons.arrow_back),
                      ),
                    ),
                  );
                }),
          ),
        )),
      ],
    );
  }
}
