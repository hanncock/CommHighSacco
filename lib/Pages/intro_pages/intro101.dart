import 'package:ezenSacco/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../wrapper.dart';

class Into101 extends StatefulWidget {

  const Into101({Key? key}) : super(key: key);


  @override
  State<Into101> createState() => _Into101State();
}

class _Into101State extends State<Into101> {

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextLiquidFill(
              boxWidth: width,
              text: 'COM HIGH SACCO',
              textAlign: TextAlign.center,
              waveColor: Colors.green,
              boxBackgroundColor: Colors.white,
              textStyle: TextStyle(
                  //fontSize: 40.0,
                  fontSize: width * 0.08,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Muli"
              ),
              //boxHeight: 300.0,
            ),
          ],
        ),
      ),
    );
  }
}
