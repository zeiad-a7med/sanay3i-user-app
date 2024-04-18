//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:userapp/sanayeeprofile.dart';
//import 'sanayeeprofile.dart';
//import 'servicecard.dart';

class FindSanayee extends StatefulWidget{

  dynamic category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description;
  FindSanayee(this.category,this.userLoc,this.selectedService,this.selectedMonth,this.selectedDay,this.selectedDayName,this.selectedTime,this.description);
  @override
  State<FindSanayee> createState() => _FindSanayeeState(category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description);
}

class _FindSanayeeState extends State<FindSanayee> {
  dynamic category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description;

  _FindSanayeeState(this.category,this.userLoc,this.selectedService,this.selectedMonth,this.selectedDay,this.selectedDayName,this.selectedTime,this.description);

  List<Marker> markers=[

  ];
  List<Circle> circles=[

  ];
  dynamic lat,long;
  int changestate=0;
  dynamic sanayees;
  getAllSnai3() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('data/snai3');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot ;
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      sanayees=values;

    });

  }
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    long = position.longitude;
    lat = position.latitude;
    circles.add(
        Circle(
            onTap: () {},
            circleId: CircleId("0"),
            center: LatLng(lat,long),
            fillColor: Color.fromRGBO(220, 134, 101, 1).withOpacity(0.3),
            radius: 7000,
            strokeWidth: 0,
            strokeColor: Colors.orange
        )
    );
    setState(() {
      changestate=1;
    });
  }
  getMarkers() async {
    List<dynamic> colores=[
      Colors.blue.withOpacity(0.3),
      Colors.green.withOpacity(0.3)
    ];
    int i=1;
    for(var id in sanayees.keys){
      if(sanayees[id]['status']=='online'){
        markers.add(
            Marker(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Sanayeeprofile(id,category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description)));
              },
              markerId: MarkerId("${i}"),
              position: LatLng(
                  sanayees[id]["lat"], sanayees[id]["long"]),
              infoWindow: InfoWindow(
                title: "${sanayees[id]["snayname"]}",
              ),
              icon: BitmapDescriptor.defaultMarker,
            )
        );
        circles.add(
            Circle(
                onTap: () {},
                circleId: CircleId("${i}"),
                center: LatLng(sanayees[id]["lat"],sanayees[id]["long"]),
                fillColor: (i%2==0)?colores[0]:colores[1],
                radius: 800,
                strokeWidth: 2,
                strokeColor: Colors.orange
            )
        );
        i++;
      }
    }
    setState(() {
      changestate=1;
    });

  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;
    getAllSnai3();
    getLocation();
    getMarkers();

    return Scaffold(appBar: AppBar(
      toolbarHeight: 50, // Set this height
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),
        onPressed:(){
          Navigator.pop(context, false);
        },
      ),
      title: Text("Find Your Sanay3i"),
      backgroundColor: Color.fromRGBO(83, 70, 102 , 1),
    ),

        body: Center(
          child:(changestate==0)?null:GoogleMap(

            onMapCreated: (controller) async {

            },
              initialCameraPosition: CameraPosition(
                target:LatLng(lat, long),
                zoom: 12,
              ),
              markers:markers.toSet(),
            circles: circles.toSet(),
          ),
        )
    );
  }
}