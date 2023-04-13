import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:temp_app_new/CreateProfile.dart';
import 'config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class SelectJobs extends StatefulWidget {
  final token;
  const SelectJobs({Key? key, this.token}) : super(key: key);

  @override
  State<SelectJobs> createState() => _SelectJobsState();
}

class _SelectJobsState extends State<SelectJobs> {
  late String userId;
  List<Map<String, dynamic>> _agriImgList = [
    {'name': 'Onion Production', 'icon': Icons.agriculture, 'isSelected': false},
    {'name': 'Wheat Production', 'icon': Icons.agriculture, 'isSelected': false},
    {'name': 'Horticulture', 'icon': Icons.agriculture, 'isSelected': false},
    {'name': 'Farm Management', 'icon': Icons.agriculture, 'isSelected': false},
    {'name': 'Wheat Harvest', 'icon': Icons.agriculture, 'isSelected': false},
  ];
  List<Map<String, dynamic>> _retailImgList = [
    {'name': 'Shelf Stacker', 'icon': Icons.shopping_cart, 'isSelected': false},

  ];

  List<Map<String, dynamic>> _hospImgList = [
    {'name': 'Waiter', 'icon': Icons.local_hospital, 'isSelected': false},
    {'name': 'Dish Washer', 'icon': Icons.local_hospital, 'isSelected': false},
    {'name': 'Petrol Pump Attendant', 'icon': Icons.local_hospital, 'isSelected': false},
  ];

  List<Map<String, dynamic>> _clericalImgList= [
    {'name': 'Data Entry Specialist', 'icon': Icons.business, 'isSelected': false},
    {'name': 'Volunteer', 'icon': Icons.business, 'isSelected': false},
    {'name': 'Administrative Assistant', 'icon': Icons.business, 'isSelected': false},
  ];


  void initState(){
    super.initState();
    // _imageFile = PickedFile('');

    // var token=widget.token;
    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    userId=jwtDecodedToken['_id'];
  }

  Future<void> sendSelectedJobs(List<Map<String, dynamic>> agriImgList,
      List<Map<String, dynamic>> retailImgList,
      List<Map<String, dynamic>> hospImgList,
      List<Map<String, dynamic>> clericalImgList,
      ) async {
    try {

      var regBody={
        'userId': userId,
        'agriculture': agriImgList.where((i) => i['isSelected']).map((i) => i['name']).toList(),
        'retail': retailImgList.where((i) => i['isSelected']).map((i) => i['name']).toList(),
        'hospitality': hospImgList.where((i) => i['isSelected']).map((i) => i['name']).toList(),
        'clerical': clericalImgList.where((i) => i['isSelected']).map((i) => i['name']).toList(),
      };

      var response=await http.post(Uri.parse(AddJob),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(regBody)
      );
      var jsonResponse=jsonDecode(response.body);

      print(jsonResponse['success']);
      if(jsonResponse['status'])
      {
        print("Job stored successfully");
        Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateProfile(token:widget.token,)));

      }else{
        print("Job not stored successfully");
      }
    } catch (error) {
      print('Error: $error');
    }
  }





  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:4,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar:AppBar(
          backgroundColor: Colors.grey[300],
          title:Text("Select your interested profession ",style: TextStyle(color: Colors.black),),
          centerTitle:true,
         bottom:TabBar(

           isScrollable:true,
          tabs:[Tab(text:'Agriculture',),

              // Navigator.push(context,MaterialPageRoute(builder:(context)=>AgriCulture()));

                 Tab(text:'Retail',),
                Tab(text:'Hospitality',),
            Tab(text:'Clerical',),

          ],
           labelColor: Colors.blueGrey,
           unselectedLabelColor: Colors.black,
         ),

        ),
        body:TabBarView(
          children: [
            buildAgriPage('Agriculture Page'),
            buildRetailPage('Retail Page'),
            buildHospitalityPage('Hospitality Page'),
            buildRetailPage('Clerical'),
          ],
        ),
        bottomNavigationBar:ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black54,
            minimumSize: Size(double.infinity,60),
          ),
          onPressed: () {
            sendSelectedJobs(_agriImgList, _retailImgList, _hospImgList, _clericalImgList);
            // Action to perform when the button is pressed
          },
          child: Text('Continue'),
        ),
      ),
    );


  }
  Widget buildAgriPage(String text)=>Center(
    child:GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: _agriImgList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _agriImgList[index]['isSelected'] =
              !_agriImgList[index]['isSelected'];
            });
          },
          child: Container(
            height: 100,
            margin: EdgeInsets.zero,
            color: _agriImgList[index]['isSelected']
                ?  Colors.black45
                :Colors.grey[300],
            child: Container(
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Icon(
                    _agriImgList[index]['icon'],
                    color: _agriImgList[index]['isSelected']
                        ? Colors.black
                        : Colors.black,
                  ),
                  Text(_agriImgList[index]['name'])
                ],
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        );
      },
    ),
  );





  Widget buildRetailPage(String text) => Center(
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: _retailImgList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _retailImgList[index]['isSelected'] =
              !_retailImgList[index]['isSelected'];
            });
          },
          child: Container(
            height: 100,
            margin: EdgeInsets.zero,
            color: _retailImgList[index]['isSelected']
                ? Colors.black45
                : Colors.grey[300],
            child: Container(
              child:Column
                (
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Icon(
                    _retailImgList[index]['icon'],
                    color: _retailImgList[index]['isSelected']
                        ? Colors.black
                        : Colors.black,
                  ),
                  Text(_retailImgList[index]['name'])
                ],
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        );
      },
    ),
  );

  Widget buildHospitalityPage(String text) => Center(
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: _hospImgList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _hospImgList[index]['isSelected'] =
              !_hospImgList[index]['isSelected'];
            });
          },
          child: Container(
            height: 100,
            margin: EdgeInsets.zero,
            color: _hospImgList[index]['isSelected']
                ? Colors.black45
                : Colors.grey[300],
            child: Container(
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Icon(
                    _hospImgList[index]['icon'],
                    color: _hospImgList[index]['isSelected']
                        ? Colors.black
                        : Colors.black,
                  ),
                  Text(_hospImgList[index]['name'])
                ],
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        );
      },
    ),
  );


  Widget buildManagementPage(String text) => Center(
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: _clericalImgList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _clericalImgList[index]['isSelected'] =
              !_clericalImgList[index]['isSelected'];
            });
          },
          child: Container(
            height: 100,
            margin: EdgeInsets.zero,
            color:_clericalImgList[index]['isSelected']
                ? Colors.black45
                : Colors.grey[300],
            child: Container(
              child:Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [

                  Icon(
                    _clericalImgList[index]['icon'],
                    color:_clericalImgList[index]['isSelected']
                        ? Colors.black
                        : Colors.black,
                  ),
                ],
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        );
      },
    ),
  );

}
