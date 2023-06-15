import 'package:ezenSacco/Pages/Authenticate/change_password.dart';
import 'package:ezenSacco/disp_pages/get_nominees.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../disp_pages/profile_display.dart';
import '../../models/class profModel.dart';
import '../../widgets/profModelView.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var networkImage ;
  var title = 'Profile';
  Widget screen = ProfDisp();

  late final profMockData = [
    ProfModel(
      active: false,
      label: 'Profile',
      route: '',
      widget: ProfDisp(),
    ),
    ProfModel(
      active: false,

      label: 'Nominees',
      route: '',
      widget: GetNomineed(),
    ),
    ProfModel(
      active: false,
      label: 'Settings',
      route: '',
      widget: ChangePassword(),
    )
  ];
  getImage()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var res = preferences.getString('image');
    setState(() {
      networkImage = res;
    });
  }


  @override
  void initState(){
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: goback(context),
        title: Text(
          'My Profile',
          style: TextStyle(
              color: Colors.redAccent,
              fontFamily: "Muli"
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[200]
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: profMockData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          childAspectRatio : MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 8),
                          crossAxisCount: profMockData.length,),
                        itemBuilder: (context, index){
                          return InkWell(
                              onTap: (){
                                setState(() {
                                  title = profMockData[index].label;
                                  screen = profMockData[index].widget;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: title == profMockData[index].label ? Colors.blue: Colors.grey[200],
                                  ),
                                  child: ProfView(profModel: profMockData[index],)
                              )
                          );
                        }),
                  )
              ),
            ),
            screen
          ],
        ),
      ),
    );
  }
}
