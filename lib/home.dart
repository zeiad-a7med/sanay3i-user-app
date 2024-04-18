import 'package:carousel_pro/carousel_pro.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Services.dart';
import 'cateogrycard.dart';
import 'Models/Cateogry.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic name="ac";
  List<Cateogry> cateogries = [];
  @override
  Widget build(BuildContext context) {
    cateogries.add(new Cateogry("AC","image/1530481.png"));
    cateogries.add(new Cateogry("carpenter","image/146619-vector-carpenter-free-hd-image.png"));
    cateogries.add(new Cateogry("smith","image/clipart-soldador-512x512-a0a7.png"));
    cateogries.add(new Cateogry("electrician ","image/6009017.png"));
    getValueFromDatabase("data/category/ac");
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color.fromRGBO(83, 70, 102 , 1),
          color: Colors.white,
          height: 55,
          items: <Widget>[
            Icon(Icons.home , size: 30,),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
          ],
          onTap: (index) {

            //Handle button tap
          },
        ),
        appBar:AppBar(
          centerTitle: true,
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
        drawer: Drawer(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 8,),
              Container(
                width: double.infinity,
                height: 300,
                child: Carousel(
                  dotSize: 6,
                  dotSpacing: 15,
                  dotPosition: DotPosition.bottomCenter,
                  images: [
                    Image(image: AssetImage("image/6f7af10029bcf59a35635b8213d55753_XL.jpg" ),fit: BoxFit.fill),
                    Image(image: AssetImage("image/2021-637605964705184931-518.jpg" ),fit: BoxFit.fill),
                    Image(image: AssetImage("image/team-welder-industrial-automotive-part-movement-factory-61568503.jpg" ),fit: BoxFit.fill),
                    Image(image: AssetImage("image/workers-manufacturing-steam-turbines-industrial-factory-129276589.jpg" ),fit: BoxFit.fill),
                  ],),
              ) ,
              Container(

                margin: EdgeInsets.only(top: 20 , left:30 , right: 30 ),
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(83, 70, 102, 1),
                  border: Border.all(width: 5 , color: Color.fromRGBO(83, 70, 102, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow:[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    ),

                  ],

                ),
                child: GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 0,
                        mainAxisExtent: 270
                    ),
                    itemCount: cateogries.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                          onTap: (){

                          },
                          child: CategoryCard(cateogries[index])
                      );
                    }
                ),
                // child: Column(
                //   children: [
                //     Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       CategoryCard("AC","image/1530481.png"),
                //       CategoryCard("carpenter","image/146619-vector-carpenter-free-hd-image.png"),
                //     ],
                //   ),Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //
                //       CategoryCard("smith","image/clipart-soldador-512x512-a0a7.png"),
                //       CategoryCard("electrician ","image/6009017.png"),
                //     ],
                //   ), ],
                //
                // ),

              ) ,
              SizedBox(
                height: 100,
              ),

            ],

          ),
        )
    );
  }
  getValueFromDatabase(String path)async{
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child(path).get();
    print( "=====> " + snapshot.value.toString()) ;
    return snapshot.value.toString() ;
  }
}
