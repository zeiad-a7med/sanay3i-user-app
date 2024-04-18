import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'pickdate.dart';
dynamic userId,userName;
class Sanayeeprofile extends StatefulWidget{

   dynamic sanayeeId,category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description;
   Sanayeeprofile(this.sanayeeId,this.category,this.userLoc,this.selectedService,this.selectedMonth,this.selectedDay,this.selectedDayName,this.selectedTime,this.description);
  @override
  State<Sanayeeprofile> createState() => _SanayeeprofileState(sanayeeId);
}

class _SanayeeprofileState extends State<Sanayeeprofile> {
   dynamic email,pass,img,phone,status,sanayeeCategory,sanayeeId,sanayeeName,lat,long="";
   dynamic Loc=LatLng(30.01,31.239);
   int changestate=0;
   _SanayeeprofileState(this.sanayeeId);

   dynamic sanayeeMarker;
   Uint8List? marketimages;

   Future<Uint8List> getImages(String path, int width) async{
     ByteData data = await rootBundle.load(path);
     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
     ui.FrameInfo fi = await codec.getNextFrame();
     return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

   }
   loadMarkers() async{
       final Uint8List markIcons = await getImages('image/carpenter.png', 100);
       sanayeeMarker=Marker(
         markerId: MarkerId('0'),
         icon: BitmapDescriptor.fromBytes(markIcons),
         position: Loc,
         infoWindow: InfoWindow(
           // given title for marker
           title: "${sanayeeName}",
         ),
       );
     setState(() {
       changestate=1;
     });

   }
   getSnai3(String id){
     DatabaseReference starCountRef = FirebaseDatabase.instance.ref('data/snai3/$id');
     starCountRef.onValue.listen((DatabaseEvent event) {
       final data = event.snapshot ;
       Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
       sanayeeName=values!["snayname"];
       sanayeeCategory=values!["category"];
       status=values!["status"];
       lat=values!["lat"];
       long=values!["long"];
       img=values!["photo"];
       email=values!["email"];
       Loc=LatLng(lat, long);

     });
     setState(() {
     });
     return ;
   }

   @override
  Widget build(BuildContext context) {
    getSnai3(sanayeeId);
    loadMarkers();


    MediaQueryData deviceInfo = MediaQuery. of(context);
    double ScreenWidth= deviceInfo.size.width;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50, // Set this height
          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),
            onPressed:() => Navigator.pop(context, false),
          ),
          title: Text("Request sanay3i"),
          backgroundColor: Color.fromRGBO(83, 70, 102 , 1),
        ),
        body: Center(
            child:Stack(
              children: [
                ListView(
                  children: [
                    Container(
                        height: 210,
                        color: Colors.white,
                        child:Stack(
                          children: [
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              color: Color.fromRGBO(83, 70, 102 , 1),
                            ),
                            Padding(
                              padding:EdgeInsets.fromLTRB(10, 30, 10, 0),
                              child: Container(

                                decoration:BoxDecoration(
                                    boxShadow:[
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5), //color of shadow
                                        spreadRadius: 5, //spread radius
                                        blurRadius: 7, // blur radius
                                        offset: Offset(0, 2), // changes position of shadow
                                        //first paramerter of offset is left-right
                                        //second parameter is top to down
                                      ),
                                      //you can set more BoxShadow() here
                                    ],
                                    border: Border.all(
                                        color: const Color(0xFF000000),
                                        width: 0.1,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.white//BorderRadius.all
                                ),
                                height:180,
                                width: (MediaQuery.of(context).size.width),
                                child: Column(
                                  children: [
                                    Container(
                                      height:100,
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child:Container(
                                                width: 80,height: 80,
                                                decoration:BoxDecoration(
                                                  image: DecorationImage(
                                                    image: Image.network("${img}").image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(65),
                                                  ),
                                                ),
                                              )
                                          ),
                                          Container(
                                            height: 120,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:EdgeInsets.fromLTRB(0, 30, 0,0),
                                                  child: Container(
                                                    width:ScreenWidth/2,
                                                    height: 27,
                                                    child:Text("${sanayeeName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), softWrap: false, maxLines: 1, overflow: TextOverflow.fade,),

                                                  ),
                                                ),
                                                Padding(
                                                  padding:EdgeInsets.fromLTRB(0, 0, 0,2),
                                                  child: Container(
                                                    width:ScreenWidth/2,

                                                    child:Text("${sanayeeCategory}",style: TextStyle(fontSize: 12,color: Colors.grey), softWrap: false, maxLines: 1, overflow: TextOverflow.fade,),

                                                  ),
                                                ),
                                                Container(
                                                  width: ScreenWidth/2,
                                                  child:Row(
                                                    children: [
                                                      Icon(Icons.star,color: Colors.yellow.shade900,),
                                                      Text("20"),
                                                      Text("(100+)",style: TextStyle(color:Colors.grey),),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child:Icon(Icons.info,color: Colors.grey,)
                                            ,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:79,
                                      child: Row(
                                        children: [
                                          Container(
                                            height:40,
                                            decoration:BoxDecoration(
                                              border: Border(
                                                right: BorderSide(color:Colors.grey),
                                              ),
                                            ),
                                            width:MediaQuery.of(context).size.width/3,
                                            child: Center(
                                              child: Padding(

                                                padding: EdgeInsets.all(0),
                                                child:Column(
                                                  children: [
                                                    Text("Deliver time",style: TextStyle(color: Colors.grey),),
                                                    Text("max 60mins"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height:40,
                                            decoration:BoxDecoration(
                                              border: Border(
                                                right: BorderSide(color:Colors.grey),
                                              ),
                                            ),
                                            width:MediaQuery.of(context).size.width/3-20,
                                            child: Center(
                                              child: Padding(

                                                padding: EdgeInsets.all(0),
                                                child:Column(
                                                  children: [
                                                    Text("",style: TextStyle(color: Colors.grey),),
                                                    Text(""),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height:45,

                                            width:MediaQuery.of(context).size.width/3-20,
                                            child: Center(
                                              child: Padding(

                                                padding: EdgeInsets.all(0),
                                                child:Column(
                                                  children: [
                                                    Text("Status",style: TextStyle(color: Colors.grey),),
                                                    Text("${status}",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 17)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child:Text("sanay3i Location",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 17),)
                    ),
                    Container(
                      width: ScreenWidth,
                      height: 1,
                      color: Colors.grey.shade500,
                    ),
                    Container(
                      width:ScreenWidth,
                      height:300,
                      child:Align(
                        alignment: Alignment.center,
                        child: Container(
                          width:ScreenWidth-50,
                          height:280,
                          child: (changestate==0)?null:GoogleMap(
                            compassEnabled: true,
                              circles: {
                                Circle(
                                  onTap: (){},
                                  circleId:CircleId("0") ,
                                  center: Loc,
                                  fillColor: Color.fromRGBO(83, 70, 102 , 1).withOpacity(0.3),
                                  radius: 400,
                                  strokeWidth: 1,
                                  strokeColor: Colors.orange

                                )
                              },
                              onMapCreated: (controller) {
                                setState(() {
                                  Loc=LatLng(lat,long);
                                });
                              },
                              initialCameraPosition: CameraPosition(
                                target: Loc,
                                zoom: 15,
                              ),
                              markers: {
                                sanayeeMarker
                              }
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: ScreenWidth,
                      height: 60,
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      color: Colors.white,
                      width:ScreenWidth,
                      height:60,
                      child:Align(
                          alignment: Alignment.topCenter,
                          child:Container(
                            color: Colors.white,
                            width: ScreenWidth-30,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(220, 134, 101, 1), //background color of button
                                  shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(5)
                                  ), //content padding inside button
                                ),
                                onPressed: ()async{
                                  // Position position = await Geolocator.getCurrentPosition();
                                  // print(position.longitude); //Output: 80.24599079
                                  // print(position.latitude); //Output: 29.6593457
                                  // dynamic long = position.longitude;
                                  // dynamic lat = position.latitude;
                                  // SendRequest(sanayeeId,widget.category,widget.userLoc,lat,long,widget.selectedService,widget.selectedMonth,widget.selectedDay,widget.selectedDayName,widget.selectedTime,widget.description);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => DoneRequest(userId,userName,img,email,phone,widget.userLoc)));
                                },
                                child: Text("Request",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),)
                            ) ,
                          )
                      )
                  ),
                )
              ],
            )
        )
    );
  }

   // void SendRequest(dynamic sanayeeId,dynamic category,dynamic userLoc,dynamic lat,dynamic long ,dynamic selectedService,dynamic selectedMonth,dynamic selectedDay,dynamic selectedDayName,dynamic selectedTime,dynamic description)async{
   //
   //   final prefs= await SharedPreferences.getInstance();
   //   userId=prefs.get("userId");
   //   dynamic userPhone=prefs.get("userPhone");
   //   userName=prefs.get("userName");
   //
   //   FirebaseFirestore.instance.collection("requests").add(
   //       <String,dynamic>{
   //         "requestId":"",
   //         "userId":userId,
   //         "sanayeeId":sanayeeId,
   //         "userLoc":userLoc,
   //         "userPhone":userPhone,
   //         "lat":lat,
   //         "long":long,
   //         "selectedService":selectedService,
   //         "category":category,
   //         "selectedMonth":selectedMonth,
   //         "selectedDay":selectedDay,
   //         "selectedDayName":selectedDayName,
   //         "selectedTime":selectedTime,
   //         "description":description,
   //         "state":"Not Accepted Yet"
   //       }
   //   );
   //
   //   //to get id form firebaseStore
   //   bool found=false;
   //   dynamic requestId;
   //   dynamic snapdata = await FirebaseFirestore.instance.collection("requests").get();
   //   for(int i=0;i<snapdata.docs.length;i++){
   //     if(snapdata.docs[i]["userId"]==userId && snapdata.docs[i]["sanayeeId"]==sanayeeId && snapdata.docs[i]["category"]==sanayeeCategory){
   //       found=true;
   //       requestId=snapdata.docs[i].id;
   //       break;
   //     }
   //   }
   //   if(found){
   //     FirebaseFirestore.instance.collection("requests").doc('${requestId}').update({
   //       'requestId' : requestId
   //     });
   //
   //   }
   //   //
   //
   // }
}