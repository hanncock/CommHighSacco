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
              text: 'COMMHIGH SACCO',
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

            // if (connected == true) GestureDetector(
            //   onTap: (){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const Wrapper()),
            //     );
            //   },
            //   child: Text(
            //     'Not Connected !!!\nRetry',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       fontSize: 14,
            //       fontFamily: "Muli",
            //       color: Colors.blueAccent,
            //     ),
            //   ),
            // ) else
            //LoadingSpinCircle()
            // Center(
            //   child: Text('${widget.displaydat}'),
            // )
            // FutureBuilder(
            //   future: Future.delayed(Duration(seconds: 5), (){auth.internetFunctions();}),//auth.internetFunctions(),
            //     builder: (BuildContext ctx, AsyncSnapshot snapshot){
            //     if(auth.internetFunctions() == 'connected'){
            //       return Center(
            //         child: Text(''),
            //       );
            //     }else{
            //       return Center(
            //         child: Text('No Connection'),
            //       );
            //     }
            //     },
            //
            // )
          ],
        ),
      ),
    );
  }
}


// class Into101 extends StatelessWidget {
// //  const Into101({Key? key}) : super(key: key);
//
//   bool connected = false;
//   final AuthService auth = AuthService();
//   @override
//   void initState() async{
//     var check_connection = await auth.internetFunctions();
//     if (check_connection == true) {
//       connected = false;
//     }else{
//       connected = true;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Container(
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: [
//
//         //width: width,
//         TextLiquidFill(
//           boxWidth: width,
//           text: 'EZEN SACCO',
//           textAlign: TextAlign.center,
//           waveColor: Colors.redAccent,
//           boxBackgroundColor: Colors.white,
//           textStyle: TextStyle(
//             fontSize: 40.0,
//             color: Colors.blueAccent,
//             fontWeight: FontWeight.bold,
//             fontFamily: "Muli"
//           ),
//           //boxHeight: 300.0,
//         ),
//
//          connected ? GestureDetector(
//            onTap: (){
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => const Wrapper()),
//              );
//            },
//            child: Text(
//              'Not Connected !!!\nRetry',
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                fontSize: 14,
//                fontFamily: "Muli",
//                color: Colors.blueAccent,
//              ),
//            ),
//          ) : LoadingSpinCircle()
//
//        ],
//       ),
//     );
//   }
// }
