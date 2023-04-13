import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class GoogleMap extends StatefulWidget {
  final token;
  const GoogleMap({super.key, this.token});



  @override
  State<GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  String locationMessage='Current Location of the User';
  String? lat;
  String? long;
  late String userId;
  initState()
  {
    _getCurrentLocation().then((value){
      lat='${value.latitude}';
      long='${value.longitude}';
      setState(() {
        locationMessage='Latitude: $lat ,Longitude: $long';
      });
      _liveLocation();
    });

    Map<String,dynamic>jwtDecodedToken=JwtDecoder.decode(widget.token);
    userId=jwtDecodedToken['_id'];
  }


  Future<void> postProfilelat(String lat) async {
    try {

      var regBody={
        "userId":userId,
        "lat":lat,
      };

      var response=await http.post(Uri.parse(AddLat),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(regBody)
      );
      var jsonResponse=jsonDecode(response.body);

      print(jsonResponse['status']);
      if(jsonResponse['status'])
      {
        print("Latitude stored successfully");
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

      }else{
        print("Latitude not stored successfully");
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

  Future<void> postProfilelong(String long) async {
    try {

      var regBody={
        "userId":userId,
        "long":long,
      };

      var response=await http.post(Uri.parse(AddLong),
          headers:{"Content-Type":"application/json"},
          body:jsonEncode(regBody)
      );
      var jsonResponse=jsonDecode(response.body);

      print(jsonResponse['status']);
      if(jsonResponse['status'])
      {
        print("Longitude stored successfully");
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));

      }else{
        print("Longitude not stored successfully");
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
//Getting Current location
  Future<Position> _getCurrentLocation() async {

    LocationPermission permission=await Geolocator.requestPermission();
    if(permission==LocationPermission.denied)
    {
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied)
      {
        return Future.error('Location permission are denied');
      }
    }

    if(permission==LocationPermission.deniedForever)
    {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      //return Future.error('Location permissions are permanently denied, we cannot request permission');
    }
    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation(){
    LocationSettings locationSettings=const LocationSettings(
      accuracy:LocationAccuracy.high,
      distanceFilter:100,
    );

    Geolocator.getPositionStream(locationSettings:locationSettings).listen((Position position) {
      var lt=lat;
      var lg=long;
      if(lt!=null && lg!=null) {
        lt = position.latitude.toString();
        lg = position.longitude.toString();
      }
    });

    setState(() {
      postProfilelat('$lat');
      postProfilelong('$long');
      locationMessage='Latitude: $lat, Longitude:$long';
    });
  }

  //Open the current location in GoogleMap
  Future<void> _openMap(String lat,String long)async{
    String googleURL='https://www.google.com/maps/search/?api=1&query=$lat,$long';
    //await canLaunchUrl(Uri.parse(googleURL))
    //? await launchUrl(Uri.parse(googleURL))
    if (!await launchUrl(Uri.parse(googleURL))) {
      throw Exception('Could not launch ${Uri.parse(googleURL)}');
    }
    //: throw 'Could not launch $googleURL';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter User location'),
        centerTitle:true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(locationMessage,textAlign:TextAlign.center,),
            const SizedBox(height:20,),
            const SizedBox(height:20,),
            ElevatedButton(
              onPressed: (){

              },
              child:const Text('Get Current Location'),
            ),
            const SizedBox(height:20,),
            ElevatedButton(onPressed: (){
              print(lat);
              print(long);
              _openMap(lat!,long!);
            },
              child:const Text("Open Google Map"),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

