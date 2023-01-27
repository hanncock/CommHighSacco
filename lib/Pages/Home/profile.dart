import 'package:ezenSacco/Pages/Authenticate/change_password.dart';
import 'package:ezenSacco/Pages/Home/homescreen.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String oldPassword ='';
  String newPassword = '';
  String confirmPassword = '';
  bool togglePassword = true;
  bool loading = false;
  bool error = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isenabled = false;

  var userid = userData[1]['userId'];
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final styles = TextStyle(fontFamily: 'Muli',fontSize: width * 0.04,color: Colors.redAccent);
    final styles2 = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width * 0.035);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.redAccent,
            fontFamily: "Muli"
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black12,
            height: height * 0.2,
            width: width,
            child:  Image.asset('assets/user.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Personal Information', style: styles,),
                InkWell(
                  onTap: (){
                    setState(() {
                      //isenabled = true;
                    });
                  },
                  child: Icon(Icons.edit,color: Colors.redAccent,),
                )
              ],
            ),
          ),

          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Column(
                    children: [
                  SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Name" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: userData[1]['name'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Name",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Company" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['company'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Company",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Member No." : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['memberNo'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Member No.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Membership Type" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['membershipType'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Membership Type.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Membership Period" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['mshipPeriodInMonths'].toString()+' Months',style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Membership Period.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Member Class" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['memberClass'].toString(),style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Member Class.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Sponsor" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['sponsorName'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Sponsor",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Email" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['email'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Email",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Phone No." : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['fixedPhone'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Phone No.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[400],
                                  padding:  EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: (){},
                                child: Text('Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Muli",
                                  ),)),
                            ElevatedButton(
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                  color: Colors.white,fontFamily: "Muli",
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding:  EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context, customePageTransion(ChangePassword()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          error ? Text('data'): Text('')
        ],
      ),
    );
  }
}
