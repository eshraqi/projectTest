import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task/task2/food_list_screen.dart';
import 'package:task/utils/app_color.dart';
import 'package:task/wigets/button_normal.dart';
import 'task1/homeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainScreenState();
}
//------------------------------------------------

class MainScreenState extends State<MainScreen> {
  //------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  //------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Padding(
            padding: const EdgeInsets.only(right: 20 , left:20),
            child:
              Row(children: [
          Expanded(child:
          ButtonNormal(
              text: "task1",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
          )),
          SizedBox(width: 20,),
          Expanded(child:
          ButtonNormal(
              text: "task2",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const FoodListScreen(listId: 1 ,listTitle: '',)),
                );
              }
          )),
        ])),
      ),
    );
  }

}
