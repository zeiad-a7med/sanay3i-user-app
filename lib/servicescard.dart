import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
class ServicesCard extends StatelessWidget {
  dynamic servicesname ,checked ;

  ServicesCard(this.servicesname,this.checked);
  @override
  isChecked(){
    return checked;
  }

  getService(){
    return servicesname;
  }
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text("$servicesname"),
        subtitle: Text(""),
        secondary: Icon(Icons.flag ,color: Color.fromRGBO(220, 134, 101, 1),),
        isThreeLine: true,
        selected: checked,
        activeColor: Color.fromRGBO(83, 70, 102, 1),
        value: checked,
      enabled: false,
      onChanged: (bool? value) {
          checked=true;
      },
    );
  }

}

