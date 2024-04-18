import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'daycard.dart';
import 'orderdetails.dart';
import 'timeslotcard.dart';
import 'package:intl/intl.dart';
class PickDate extends StatefulWidget{
  String iconImg="";
  String category="";
  String userLoc="";
  dynamic selectedService;
  String dayName = DateFormat('EEEE') .format(DateTime.now()).substring(0,3);
  String currentDay = DateFormat('dd').format(DateTime.now());
  String currentMonth = DateFormat('MM').format(DateTime.now());
  PickDate(this.iconImg,this.category,this.selectedService,this.userLoc);
  @override
  State<PickDate> createState() => _PickDateState(iconImg,category,selectedService,userLoc,dayName,currentMonth,currentDay);
}

class _PickDateState extends State<PickDate> {

  String superMonth=DateFormat('MM').format(DateTime.now());
  String superday=DateFormat('dd').format(DateTime.now());
  String hour = DateFormat("HH").format(DateTime.now());
  dynamic selectedService;
  String userLoc="";
  String iconImg="";
  String category="";
  String dayName="";
  String currentDay="";
  String currentMonth ="";

  int selectedDay=-1;

  String selectedDayName="";
  int selectedTime=0;
  _PickDateState(this.iconImg,this.category,this.selectedService,this.userLoc,this.dayName,this.currentMonth,this.currentDay);
  @override
  Widget build(BuildContext context) {


    List<String> months=[
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    List<String> monthsShort=[
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    List<String> days=[
      "Sat",
      "Sun",
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
    ];
    List<String> monthDaysWithNames=[];
    List<String> monthDays=[];


    int startDayIndex=0;
    String a=dayName.substring(0,3);

    for(int i=0;i<7;i++){
      if(a==days[i])
        startDayIndex=i;
    }
    if(int.parse(currentMonth)==1||int.parse(currentMonth)==3||int.parse(currentMonth)==5||int.parse(currentMonth)==7||int.parse(currentMonth)==7||int.parse(currentMonth)==10||int.parse(currentMonth)==12){
      for(int i=int.parse(currentDay);i<=31;i++){
        if(startDayIndex==7)
          startDayIndex=0;
        monthDays.add(i.toString());
        monthDaysWithNames.add(days[startDayIndex]);
        startDayIndex++;
      }
    }else if(int.parse(currentMonth)==2){
      for(int i=int.parse(currentDay);i<=28;i++){
        if(startDayIndex==7)
          startDayIndex=0;
        monthDays.add(i.toString());
        monthDaysWithNames.add(days[startDayIndex]);
        startDayIndex++;
      }
    }else{
      for(int i=int.parse(currentDay);i<=30;i++){
        if(startDayIndex==7)
          startDayIndex=0;
        monthDays.add(i.toString());
        monthDaysWithNames.add(days[startDayIndex]);
        startDayIndex++;
      }
    }



    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;
    print(category);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50, // Set this height
          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),
            onPressed:() => Navigator.pop(context, false),
          ),
          title: Text("Pick Date and Time"),
          backgroundColor: Color.fromRGBO(83, 70, 102 , 1),
        ),
        body: Center(
            child:Stack(
              children: [
                ListView(
                  children: [
                    Container(
                      height: 200,
                      width: ScreenWidth,
                      color: Color.fromRGBO(83, 70, 102 , 1),
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                              width: ScreenWidth/4,
                              height: 200,
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon:Icon(Icons.arrow_back_ios,color: Colors.orange,size: 30),
                                  onPressed:(currentMonth=='01'||currentMonth=='1'||currentMonth==superMonth)?null:(){
                                      setState(() {
                                        if(int.parse(currentMonth)-1==int.parse(superMonth)){
                                          currentDay=superday;
                                        }
                                        int a=(int.parse(currentMonth))-1;
                                        currentMonth=a.toString();
                                      });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: ScreenWidth/2,
                              height: 200,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('${months[(int.parse(currentMonth))-1]}',style: TextStyle(color: Colors.orange,fontSize: 30),),
                              ),
                            ),
                            Container(
                              width: ScreenWidth/4,
                              height: 200,
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon:Icon(Icons.arrow_forward_ios,color: Colors.orange,size: 30),
                                  onPressed:(currentMonth=='12')?null:(){
                                    setState(() {
                                      int a=(int.parse(currentMonth))+1;
                                      currentMonth=a.toString();
                                      currentDay='01';
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: ScreenWidth,
                      height: 50,
                      color: Color.fromRGBO(83, 70, 102 , 1),
                      child: ListView(
                        scrollDirection: axisDirectionToAxis(AxisDirection.right),
                        children: [
                          for(int i=0 ;i<monthDays.length;i++)
                            ElevatedButton(
                            onPressed:(){
                                setState(() {
                                  selectedDay=int.parse(monthDays[i]);
                                  selectedDayName=monthDaysWithNames[i];
                                });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              primary: Colors.black, //background color of button
                              //content padding inside button
                            ),
                            child: Container(
                              width: 70,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border:Border(
                                    bottom: BorderSide(width: 3, color:(selectedDay==int.parse(monthDays[i]))?Colors.orange:Colors.white),
                                  )
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("${monthDays[i]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:(selectedDay==int.parse(monthDays[i]))?Colors.orange:Colors.white),),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("${monthDaysWithNames[i]}",style: TextStyle(fontSize: 15,color: (selectedDay==int.parse(monthDays[i]))?Colors.orange:Colors.white),),
                                  ),
                                ],
                              ),

                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child:Text("Choose Time Slots",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 17),)
                    ),
                    Container(
                      width: ScreenWidth,
                      height: 1,
                      color: Colors.grey.shade500,
                    ),

                    Container(
                      width: ScreenWidth,
                      child: Column(
                        children: [
                          Container(
                            width: ScreenWidth,
                            height:70,
                            child:Row(

                              children: [
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),

                                      onPressed:(9-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=9;
                                        });
                                      },
                                      child:TimeSlotCard("9am - 10am", (((9-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==9)?true:false),

                                  ),

                                ),
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(10-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=10;
                                        });
                                      },
                                      child:TimeSlotCard("10am - 11am", (((10-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==10)?true:false),

                                  ),

                                ),
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(11-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=11;
                                        });
                                      },
                                      child:TimeSlotCard("11am - 12pm", (((11-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==11)?true:false),

                                  ),

                                ),

                              ],
                            ),
                          ),
                          Container(
                            width: ScreenWidth,
                            height:70,
                            child:Row(

                              children: [
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(12-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=12;
                                        });
                                      },
                                      child:TimeSlotCard("12pm - 1pm", (((12-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==12)?true:false),

                                  ),

                                ),
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(13-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=13;
                                        });
                                      },
                                      child:TimeSlotCard("1pm - 2pm", (((13-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==13)?true:false),

                                  ),

                                ),
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(14-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=14;
                                        });
                                      },
                                      child:TimeSlotCard("2pm - 3pm", (((14-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==14)?true:false),

                                  ),

                                ),




                              ],
                            ),
                          ),
                          Container(
                            width: ScreenWidth,
                            height:70,
                            child:Row(

                              children: [
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(15-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=15;
                                        });
                                      },
                                      child:TimeSlotCard("3pm - 4pm", (((15-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==15)?true:false),

                                  ),

                                ),
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(16-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=16;
                                        });
                                      },
                                      child:TimeSlotCard("4pm - 5pm", (((16-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==16)?true:false),


                                  ),

                                ),
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(17-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=17;
                                        });
                                      },
                                      child:TimeSlotCard("5pm - 6pm", (((17-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==17)?true:false),

                                  ),

                                ),



                              ],
                            ),
                          ),
                          Container(
                            width: ScreenWidth,
                            height:70,
                            child:Row(

                              children: [
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(18-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=18;
                                        });
                                      },
                                      child:TimeSlotCard("6pm - 7pm", (((18-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==18)?true:false),

                                  ),

                                ),
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(19-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=19;
                                        });
                                      },
                                      child:TimeSlotCard("7pm - 8pm", (((19-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==19)?true:false),

                                  ),

                                ),
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(20-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=20;
                                        });
                                      },
                                      child:TimeSlotCard("8pm - 9pm", (((20-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==20)?true:false),

                                  ),

                                ),




                              ],
                            ),
                          ),
                          Container(
                            width: ScreenWidth,
                            height:70,
                            child:Row(

                              children: [
                                Container(
                                  width:ScreenWidth/6,
                                    height:40
                                ),
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(21-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=21;
                                        });
                                      },
                                      child:TimeSlotCard("9pm - 10pm", (((21-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==21)?true:false),

                                  ),

                                ),
                                SizedBox(
                                  width:ScreenWidth/3,
                                  height:40,
                                  child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),

                                        primary: Colors.white, //background color of button
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(30)
                                        ), //content padding inside button
                                      ),


                                      onPressed:(22-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)?null:(){
                                        setState(() {
                                          selectedTime=22;
                                        });
                                      },
                                      child:TimeSlotCard("10pm - 11pm", (((22-2<int.parse(hour)&&selectedDay==int.parse(superday)||selectedDay==-1)))?false:true,(selectedTime==22)?true:false),

                                  ),

                                ),



                                Container(
                                    width:ScreenWidth/6,
                                    height:40
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      width:ScreenWidth
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
                                onPressed:(selectedTime==0||selectedDay==0||selectedDayName=="")? null: (){

                                  dynamic selectedMonth=monthsShort[int.parse(currentMonth)-1];

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails("",category,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,"userLoc")));
                                },
                                child: Text("Proceed",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),)
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
}