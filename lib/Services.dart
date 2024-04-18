
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'pickdate.dart';
import 'selected.dart';
import 'Home.dart';
import 'orderdetails.dart';
import 'servicescard.dart';

class Services extends StatefulWidget {

  dynamic cat;
  Services(this.cat);


  @override
  State<Services> createState() => _ServicesState(cat);
}

class _ServicesState extends State<Services> {
  dynamic cat;

  _ServicesState(this.cat);
  List<dynamic>services=[
    new ServicesCard("charging conditioning" ,false),
    new ServicesCard("compressor services" ,false),
    new ServicesCard("filters services" ,false),
    new ServicesCard("filtersss services" ,false),
    new ServicesCard("filtersvv services" ,false),
    new ServicesCard("filters33 services" ,false),
  ];
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        leading: new IconButton(
          icon:Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pop();
          }
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("image/electricity-clipart-electrical-equipment-3.png"),width: 30,height: 30,),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Online Maintnance Services',
              style: TextStyle(color: Colors.white , fontSize: 15),
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(83, 70, 102 , 1), //<-- SEE HERE
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              margin: EdgeInsets.only( bottom: 15 ),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("image/Hero-Services-Air-Conditioning-Repair-Knoxville-scaled-1-1024x683.jpg"),fit: BoxFit.fill)
              ),
            ),
            SizedBox(height: 20,),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 15),

                child:
            Text("Choose your Services" , style: TextStyle(fontSize: 25))),
            Divider(),
            
            for(int i=0;i<services.length;i++)
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: (){
                    setState(() {
                      if(services[i].isChecked()==true){
                        dynamic x=new ServicesCard(services[i].getService(), false);
                        services[i]=x;
                      }else{
                        dynamic x=new ServicesCard(services[i].getService(), true);
                        services[i]=x;
                      }
                    });
                  },
                  child:services[i]
              ),

            // FutureBuilder(
            //   future: mydb.query("contact"),
            //   builder:(context, AsyncSnapshot snapshot){
            //     if(snapshot.hasData==true){
            //       return ListView.builder(
            //         itemCount: snapshot.data.length,
            //         itemBuilder:(context,i){
            //
            //           return CheckboxListTile(
            //               title: Text("${snapshot.data[i]["name"]}"),
            //               subtitle: Text("${cat}" , style: TextStyle(color: Color.fromRGBO(220, 134, 101, 1)),),
            //               secondary: Icon(Icons.flag ,color: Color.fromRGBO(220, 134, 101, 1),),
            //               isThreeLine: true,
            //               selected: fan,
            //               activeColor: Color.fromRGBO(83, 70, 102, 1),
            //               value: fan, onChanged: (val){
            //             setState(() {
            //               fan=val;
            //             });
            //           });
            //
            //         },
            //       );
            //     } else{
            //       return Text("no data");
            //     }
            //   },
            // ),




            SizedBox(height: 15,),
            ElevatedButton(onPressed: (){
              List<String>selectedServices=[];
              for(int i=0;i<services.length;i++){
                if(services[i].isChecked()==true){
                  selectedServices.add(services[i].getService());
                }
              }
              Navigator.push(context, new MaterialPageRoute(builder: (context)=>new PickDate("iconImg",cat,selectedServices,"userLoc"),));

              print(selectedServices);
            }, child:Text("Add" , style: TextStyle(fontSize: 20),) , style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(220, 134, 101, 1),
              fixedSize:Size(80, 50),
            ), ),
            SizedBox(height: 30,),


          ],

        ),
      )
    );
  }
}
