import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:sanayee/orderdetails.dart';
//import 'orderdetails.dart';
class TimeSlotCard extends StatelessWidget{

  String time="";
  bool available,selected=false;
  dynamic color="";
  TimeSlotCard(this.time,this.available,this.selected);
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;
    if(available){
      color= Colors.black;
    }else{
      color=Colors.grey;
    }

    return Container(
      width: ScreenWidth/3,
      height:50,
      child: Align(
        alignment: Alignment.center,
        child:SizedBox(
            height:40, //height of button
            width:ScreenWidth/3.2 , //width of button
            child:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: (selected)?Colors.black:Colors.grey.shade300,
                ),

                child: Align(
                  alignment: Alignment.center,
                  child: Text("${time}",style: TextStyle(color:(selected)?Colors.white:color,fontSize: 17,fontWeight: FontWeight.w400),),
                )
            )
        )
        ,
      ),
    );
  }
}