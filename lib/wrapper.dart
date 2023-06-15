import 'dart:async';
import 'dart:convert';
import 'package:ezenSacco/Pages/Authenticate/authenticate.dart';
import 'package:ezenSacco/Pages/Home/homescreen.dart';
import 'package:ezenSacco/Pages/intro_pages/intro101.dart';
import 'package:ezenSacco/Pages/intro_pages/intropage1.dart';
import 'package:ezenSacco/Pages/intro_pages/intropage2.dart';
import 'package:ezenSacco/Pages/intro_pages/intropage3.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

var userData;
var width;
var height;
class _WrapperState extends State<Wrapper> {

  PageController _controller = PageController();
  bool onLastPage = false;
  int activeIndex = 0;
  bool loggedin = true;
  bool connected = true;
  final AuthService auth = AuthService();
  var currentUserDat;

  void initState() {
    checkConnection().whenComplete(() async{
      getValidationData().whenComplete(() async{
        Timer(const Duration(seconds: 2), () {if(userData == null){
          setState(() {
            loggedin != loggedin;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));

        }});
      });
    }
    );
    super.initState();
  }

  checkConnection() async{
    var check_connection = await auth.internetFunctions();
    if (check_connection == 'connected') {
      // carouselInfo();
      setState(() {
        connected = true;
      });
    }else{
      setState(() {
        connected = false;
      });
    }
  }


  Future getValidationData() async{
    print('validating the data');
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedEmail= sharedPreferences.getString('email');
    List multidata = jsonDecode(obtainedEmail!);
    if(multidata[0] == 'https://ezen.commhighsacco.com'){
      print(multidata);
      print('wrong url in use');
      multidata.replaceRange(0,0+1,['https://web.ezenfinancials.com']);
      sharedPreferences.setString('email', jsonEncode(multidata));
      print(multidata);
    }
    setState(() {
      multidata.add(currentUserDat);
      userData = multidata;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    width = screenwidth;
    height = screenheight;
    checkConnection();

      return Scaffold(
        body: Container(
          color: Colors.deepPurple.withOpacity(0.05),

          child: loggedin ? Into101() :  Stack(
            children: [
              PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    onLastPage = (index == 2);
                  });
                },
                children: [
                  IntroPage1(),
                  IntroPage2(),
                  IntroPage3(),
                ],
              ),
            ],
          ),
        ),
      );
  //  }
  }
  buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count:3,
      effect: JumpingDotEffect(
        dotHeight: 10,
        dotWidth: 10,
        dotColor: Colors.grey,
        activeDotColor: Colors.redAccent,
       )
  );
}
