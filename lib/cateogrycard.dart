import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/Cateogry.dart';
import 'Services.dart';
class CategoryCard extends StatelessWidget{
  Cateogry cateogry;
  CategoryCard(this.cateogry);
  @override Widget build(BuildContext context) {
     return Container(
       width: 150,
       height: 180,
       margin: EdgeInsets.only(top: 55 , bottom: 50),
       decoration: BoxDecoration(
           color: Color.fromRGBO(220, 134, 101, 1),
           border: Border.all(width: 5 , color: Color.fromRGBO(220, 134, 101, 1)),
           borderRadius: BorderRadius.all(Radius.circular(10)),
           boxShadow:[
             BoxShadow(
               color: Colors.grey.withOpacity(0.5),
               spreadRadius: 5,
               blurRadius: 7,
               offset: Offset(0, 2),
             ),

           ]
       ),
       child: Column(
         children: [
           ElevatedButton(
             onPressed: (){
               Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Services(cateogry.name),));
             },
             child: Image(image: AssetImage("${cateogry.image}"),width: 110 , height: 110,fit: BoxFit.fill,) , style:
           ElevatedButton.styleFrom(
             primary: Color.fromRGBO(220, 134, 101, 1),
           ),),
           SizedBox(height: 20,),
           Text("${cateogry.name}" , style:TextStyle(color: Colors.white , letterSpacing: 1 , fontSize: 17)  ,)
         ],
       ),
     );
  }
}