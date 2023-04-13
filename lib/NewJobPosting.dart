import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
class NewJobPosting extends StatefulWidget {
  final token;
  const NewJobPosting({Key? key, this.token}) : super(key: key);

  @override
  State<NewJobPosting> createState() => _NewJobPostingState();
}

class _NewJobPostingState extends State<NewJobPosting> {
  late String userId;
  DateTimeRange dateRange=DateTimeRange(start: DateTime(2022,11,5), end:DateTime(2022,12,24));

  final items=['Onion Production','Wheat Production','Horticulture','Farm Management',
    'Wheat Harvest','Shelf Stacker','Waiter','Dish Washer','Petrol Pump Attendant',
    'Data Entry Specialist','Volunteer','Administrative Assistant'];
  String? value;


  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState(){
    super.initState();
    // _imageFile = PickedFile('');
    // var token=widget.token;
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    userId=jwtDecodedToken['_id'];
  }

  Future<void> postProfileProfession() async {
    try {

      var regBody={
        "userId":userId,
        "type":value,
        "lat":latController.text,
        "long":longController.text,
        "date":dateController.text,
        "time":timeController.text,
        "price":priceController.text
      };

      var response=await http.post(Uri.parse(AddNewJobPost),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(regBody)
      );
      var jsonResponse=jsonDecode(response.body);

      print(jsonResponse['status']);
      if(jsonResponse['status'])
      {
        print("New Job stored successfully");
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

      }else{
        print("New Job not stored successfully");
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
    final start=dateRange.start;
    final end=dateRange.end;
    return Padding(padding: EdgeInsets.all(20.0),
    child:Column(
        children: [
          Container(
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(12),
              border:Border.all(color:Colors.black,width:2)
            ),
            child:DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value:value,
                isExpanded:true,
                icon:Icon(Icons.arrow_drop_down,color:Colors.black),
                items:items.map(buildMenuItem).toList(),
                onChanged:(value)=>setState(()=>this.value=value),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:TextField(
              cursorColor: Colors.black,
              controller: latController,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                hintStyle: TextStyle(color: Colors.black),
                filled:true,
                errorStyle:TextStyle(color:Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black), // set border color
                ),
                hintText: 'Enter latitude',
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:TextField(
              cursorColor: Colors.black,
              controller: longController,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled:true,
                errorStyle:TextStyle(color:Colors.red),
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black), // set border color
                ),
                hintText: 'Enter longitude',
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Date Range',
            style:TextStyle(fontSize:20),
          ),
          const SizedBox(height:20,),
          // Row(
          //   mainAxisAlignment:MainAxisAlignment.center,
          //   children: [
          //     Expanded(child:ElevatedButton(
          //       child:Text('${start.year}/${start.month}/${start.day}'),
          //       onPressed:pickDateRange,
          //     ),
          //     ),
          //     const SizedBox(width:12,),
          //     Expanded(child:ElevatedButton(
          //       onPressed:pickDateRange,
          //       child:Text('${end.year}/${end.month}/${end.day}'),
          //
          //     ))
          //
          //   ],
          // ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:TextField(
              cursorColor: Colors.black,
              controller: dateController,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled:true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black), // set border color
                ),
                errorStyle:TextStyle(color:Colors.red),
                hintStyle: TextStyle(color: Colors.black),
                hintText: 'like mm/dd/yy-mm/dd/yy',
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Time Range',
            style:TextStyle(fontSize:20),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:TextField(
              cursorColor: Colors.black,
              controller: timeController,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                filled:true,
                fillColor: Colors.grey[300],
                errorStyle:TextStyle(color:Colors.red),
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black), // set border color
                ),
                hintText: 'like 09:00AM - 16:00PM',
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:TextField(
              cursorColor: Colors.black,
              controller: priceController,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled:true,
                errorStyle:TextStyle(color:Colors.red),
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black), // set border color
                ),
                hintText: 'Enter price',
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:(){
              postProfileProfession();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => TypeScreen()),
              // );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black54),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
    ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange=await showDateRangePicker(context: context,
        initialDateRange:dateRange,
        firstDate: DateTime(1900), lastDate:DateTime(2100));

    if(newDateRange==null)return; //pressed 'X'
    setState(()=>dateRange=newDateRange);

  }
  
  
  DropdownMenuItem<String> buildMenuItem(String item)=>DropdownMenuItem(value:item,
    child: Text(
      item,
      style:TextStyle(fontWeight:FontWeight.bold,fontSize:16),
    ),
  );
      
}

