import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'services.dart';
class DayCard extends StatelessWidget{
  bool selected=false;
  String dayNumber="";
  String dayName="";

  DayCard(this.selected,this.dayName,this.dayNumber);
  Widget build(BuildContext context) {
    dynamic myColor=(selected)?Colors.orange:Colors.white;

    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;
    return ElevatedButton(
      onPressed:(){},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        primary: Color.fromRGBO(83, 70, 102 , 1), //background color of button
        //content padding inside button
      ),
      child: Container(
        width: 70,
        height: 50,
        color: Color.fromRGBO(83, 70, 102 , 1), //background color of button
        decoration: BoxDecoration(

            border:Border(
              bottom: BorderSide(width: 3, color: myColor),
            )
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text("${dayNumber}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: myColor),),
            ),
            Align(
              alignment: Alignment.center,
              child: Text("${dayName}",style: TextStyle(fontSize: 15,color: myColor),),
            ),
          ],
        ),

      ),
    )
    ;
  }
}