import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class geolocation extends StatefulWidget {

  const geolocation({Key? key}) : super(key: key);

  @override
  _geolocationState createState() => _geolocationState();
}

class _geolocationState extends State<geolocation> {

  final Completer<GoogleMapController> _controller=Completer();
  String Latitude="";
  String Longitude="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Locationdata();
  }
  static const CameraPosition positionplex=CameraPosition(
      target: LatLng(33.6844, 73.0479),
      zoom: 14,
  );
    final List<Marker> _markers=<Marker>[
      Marker(markerId: MarkerId('1'),
      position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(
          title: 'Marker'
        )
      )
    ];

   Future<Position> getcurrentlocation() async{
    LocationPermission permission;
    permission =await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permission are denied');
      }
    }
    final geoposition=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      Latitude='${geoposition.latitude}';
      Longitude='${geoposition.longitude}';
    });
    return geoposition;
   }
    Locationdata(){
      getcurrentlocation().then((value)async{
        _markers.add(
            Marker(
                markerId: MarkerId('2'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(
                    title: 'My current location'
                )
            )
        );
        CameraPosition cameraPosition=CameraPosition(
            target: LatLng(value.latitude, value.longitude));
        final GoogleMapController controller=await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {

        });
      });
    }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: positionplex,
          markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            Locationdata();
            },
          child: Icon(Icons.add_location),
           )
    );
  }
}
