import 'dart:async';

import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);


  @override
  void iniState(){
    Timer(const Duration(seconds: 2), (){
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: [
       Container(
         child: Column(
           children: [
             Text(
               'CommHigh Sacco'.toUpperCase(),
               textAlign: TextAlign.center,
               style: TextStyle(
                 fontSize: width * 0.1,
                 fontFamily: "Muli",
                 color: Colors.redAccent
               ),
             ),
             Text(
                 'Welcome to CommHigh Sacco, Let’s save!',
               textAlign: TextAlign.center,
               style: TextStyle(
                 fontSize: 20,
                 fontFamily: "Muli",
                 color: Colors.blueAccent
               ),
             )
           ],
         ),
       ),
       Container(
         width: width,
         height: height * 0.5,
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage('assets/splash_1.png'),
             fit: BoxFit.fill,
           ),
         ),
       ),
       SizedBox(height: 20,)
     ],
    );
  }
}
