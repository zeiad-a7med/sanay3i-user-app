import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
class Selected extends StatelessWidget {
  dynamic list ;

  Selected(this.list);
  @override

  Widget build(BuildContext context) {
    return Text("${list}");
  }

}

