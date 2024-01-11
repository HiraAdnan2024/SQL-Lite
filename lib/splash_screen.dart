import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_sql_lite/screen/todo_list_screen.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Future.delayed(
      Duration(seconds: 2),
          (){
        // Get.off(TodoListScreen());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TodoListScreen()),
        );
      },
    );
    return Scaffold(
      body: Center(
        child: Text('Your Todo App'),
      ),
    );
  }

}