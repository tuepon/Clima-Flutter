import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    print('this line of code is triggered');
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    Response response = await get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=secret'));
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      double temperature = decodedData['main']['temp'];

      int condition = decodedData['weather'][0]['id'];

      String cityName = decodedData['name'];

      print(temperature);
      print(condition);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}

// @override
// Widget build(BuildContext context) {
//   String myMargin = '15';
//   double myMarginAsADouble;
//
//   try {
//     myMarginAsADouble = double.parse(myMargin);
//   } catch (e) {
//     print(e);
//   }
//
//   return Scaffold(
//     body: Container(
//       margin: EdgeInsets.all(myMarginAsADouble ?? 30.0),
//       color: Colors.red,
//     ),
//   );
// }
