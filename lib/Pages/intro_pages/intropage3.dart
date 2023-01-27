import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

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
                'Ezen Sacco'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: width * 0.1,
                    color: Colors.redAccent
                ),
              ),
              Text(
                'Welcome to Ezen Sacco, Let’s save!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
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
              image: AssetImage('assets/splash_3.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}
