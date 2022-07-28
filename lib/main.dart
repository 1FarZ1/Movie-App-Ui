
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math/Screens/detailes.dart';
import 'package:math/Screens/home.dart';


void main() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp( 
     MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:"/",
      routes:{


        "/":(context)=>Home(),

      }
      
    ,
  ));
}
