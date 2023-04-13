import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class ReviewScreen extends StatefulWidget {
  final rId;
   final userId;
  ReviewScreen(this.rId,  this.userId, {Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController reviewController = TextEditingController();

  // get rId => rId;

  // get userId => userId;

  void storeReview() async {
    try {

      var regBody={
        'rId': widget.rId,
        'userId':widget.userId,
        'review':reviewController.text,
      };

      var response=await http.post(Uri.parse(StoreReview),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(regBody)
      );
      var jsonResponse=jsonDecode(response.body);

      print(jsonResponse['status']);
      if(jsonResponse['status'])
      {
        print(jsonResponse['status']);
        print("Review stored successfully");


          Navigator.pop(context);

      }else{
        print("Review not stored successfully");
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            TextField(
              cursorColor: Colors.black,
              maxLines:8,
              controller: reviewController,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled:true,
                errorStyle:TextStyle(color:Colors.red),
                hintStyle: TextStyle(color: Colors.black),
                hintText: 'Enter Review',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // set rounded corners
                  borderSide: BorderSide.none, // remove the border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black), // set border color
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height:10,),
            ElevatedButton(
              onPressed:(){
                storeReview();

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
                  Size(MediaQuery.of(context).size.width / 4.5, 40),
                ),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        )


      ),
    );
  }
}
