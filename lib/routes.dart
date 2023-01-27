import 'package:ezenSacco/Pages/Home/base_screen.dart';
import 'package:ezenSacco/Pages/Home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class routes{
  final routedata;

  routes({required this.routedata, data});

  generateRoute(RouteSettings settings) {
    final Map arguments = settings.arguments as Map;
    final storage = FlutterSecureStorage();
    print('Route ${settings.name}');
    print('DATA :: $routedata');
    switch (settings.name){
      case '/':
      final Map arguments = settings.arguments as Map;

      //print('my params $arguments');
      if (arguments != null) {
        //return customePageTransion(Login());
      } else if (routedata.length > 0) {
        //return customePageTransion(Login());
      }
     // return customePageTransion(Login());
      break;
      case '/home':
        return customePageTransion(Home());
      case "/splash":
      //ensure the user is logged out by clearing all the current session
        //storage.deleteAll();
        return customePageTransion(BaseScreen());

    }
  }

}

PageRouteBuilder customePageTransion(newRoute) {
  return PageRouteBuilder(
      pageBuilder: (_, __, ___) => newRoute,
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
            axisAlignment: 0.0,
          ),
        );
      });
}