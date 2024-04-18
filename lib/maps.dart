import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatelessWidget{
  List<Marker> markers=[
    Marker(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => Sanayeeprofile(sanayeeId,category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description)));

      },
      markerId: MarkerId("1"),
      position: LatLng(
          30.081538022948937, 31.197425461822554),
      infoWindow: InfoWindow(
        title: "zeiad",
      ),
      icon: BitmapDescriptor.defaultMarker,
    ),
    Marker(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => Sanayeeprofile(sanayeeId,category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description)));

      },
      markerId: MarkerId("2"),
      position: LatLng(
          30.062837556334898, 31.198347075496677),
      infoWindow: InfoWindow(
        title: "ma7ame7o",
      ),
      icon: BitmapDescriptor.defaultMarker,
    )
  ];

  List<Circle> circles=[
    Circle(
        onTap: () {},
        circleId: CircleId("1"),
        center: LatLng(
            30.081538022948937, 31.197425461822554),
        fillColor: Colors.blue.withOpacity(0.3),
        radius: 800,
        strokeWidth: 2,
        strokeColor: Colors.orange
    ),
    Circle(
        onTap: () {},
        circleId: CircleId("2"),
        center: LatLng(
            30.062837556334898, 31.198347075496677),
        fillColor:Colors.green.withOpacity(0.3) ,
        radius: 800,
        strokeWidth: 2,
        strokeColor: Colors.orange
    ),
  ];

  dynamic lat,long;

  int changestate=1;

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;

    return Scaffold(


        body: Center(
          child:GoogleMap(
            onMapCreated: (controller) async {

            },
            initialCameraPosition: CameraPosition(
              target: (lat==null)?LatLng(30.04936635347326, 31.23752495928705):LatLng(lat, long),
              zoom: 12,
            ),
            markers:markers.toSet(),
            circles: circles.toSet(),
          ),
        )
    );
  }
}