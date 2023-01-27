import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/material.dart';


//import 'package:ezenSacco/widgets/404.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final storage = new FlutterSecureStorage();
//   final data = await storage.readAll();
//   runApp(Provider(
//       create: (BuildContext context) {  },
//       child: MyApp(
//         data: data,
//       )));
// }
//
// class MyApp extends StatelessWidget {
//   MyApp({@required this.data});
//   // This widget is the root of your application.
//   final data;
//   @override
//   Widget build(BuildContext context) {
// //change notification bar color
// //     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
// //       statusBarIconBrightness: Brightness.dark,
// //       statusBarColor: Color(0XFFFEFEFE),
// //     ));
//
//     return MaterialApp(
//       title: 'Ezen Sacco',
//       debugShowCheckedModeBanner: false,
//       //theme: theme(),
//       onGenerateRoute: (settings) =>
//           routes(routedata: data).generateRoute(settings),
//       onUnknownRoute: (RouteSettings settings) {
//         return MaterialPageRoute<void>(
//           settings: settings,
//           builder: (BuildContext context) => PageNotFound(),
//         );
//       },
//     );
//   }
// }

// var data;
void main() => runApp(MaterialApp(
  theme: ThemeData(
    fontFamily: "Muli",
    primaryColor: Colors.redAccent
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => Wrapper(),

  },
  //home: Wrapper()
));
// Future main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await initialization(null);
//
//   runApp(MaterialApp(
//     initialRoute: '/',
//     routes: {
//       '/': (context) => Wrapper(),
//     },
//   ));
// }
//
// Future initialization(BuildContext? context) async{
//   await Future.delayed(Duration(seconds: 3));
// }
