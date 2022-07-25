import 'package:flutter/material.dart';
import 'package:geolocator_plugin/location_file.dart';

void main(){
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
     home: Myapp()
      )
    );
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: geolocation(),
    );
  }
}
