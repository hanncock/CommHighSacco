import 'package:ezenSacco/Pages/Home/home_drawwer.dart';
import 'package:ezenSacco/Pages/Home/homescreen.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _WidgetOptions = <Widget>[
    Home(),
    AppDrawwer(),
    AppDrawwer(),
    AppDrawwer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _WidgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //selectedIconTheme: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card),label: "Cards"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart),label: "Overview"),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index){
          setState(() {
            print('cliked');
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
