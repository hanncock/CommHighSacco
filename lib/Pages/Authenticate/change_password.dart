import 'package:ezenSacco/Pages/Home/profile.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

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
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
              color: Colors.blue.withOpacity(0.8),
              height: height * 0.3,
              width: width,
              child:  Center(
                child: Text('CHANGE PASSWORD',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    // color: Color(0xFF5C000E),
                  ),),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    //enabled: isenabled,
                    validator: (val) => val!.isEmpty ? "Enter  Old Password" : null,
                    onChanged: (val){setState(() => oldPassword = val);},
                    decoration: InputDecoration(
                      hintText: 'Old Password',
                      hintStyle: TextStyle(fontSize: width * 0.04),
                      suffixIcon: Icon(Icons.account_box),
                      labelText: "Previous Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusColor: Colors.redAccent,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? "Enter  New Password" : null,
                    obscureText: togglePassword,
                    onChanged: (val) {setState(() => newPassword = val);},
                    decoration: InputDecoration(
                      hintText: 'Enter New Password',
                      hintStyle: TextStyle(fontSize: width * 0.04),
                      labelText: "New Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: GestureDetector(
                        child: Icon(togglePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onTap: () {
                          setState(() {
                            togglePassword = !togglePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? "Confirm Password" : null,
                    obscureText: togglePassword,
                    onChanged: (val) {setState(() => confirmPassword = val);},
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(fontSize: width * 0.04),

                      labelText: "Confirm Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: GestureDetector(
                        child: Icon(togglePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onTap: () {
                          setState(() {
                            togglePassword = !togglePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.04
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding:  EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () async {
                            //if(auth.internetFunctions() == false){
                            //print('connected');
                            if (_formKey.currentState!.validate()) {
                              setState(() { loading = true;});
                              try{
                                dynamic result = await auth.changePassword(userid, oldPassword, newPassword, confirmPassword);
                                print(result);
                                if(result['success'] == "false"){
                                  setState(() {
                                    loading = false;
                                    Fluttertoast.showToast(
                                        msg:  result['message'],
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        //backgroundColor: Colors.white,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  });
                                }else{
                                  setState(()  {
                                    Fluttertoast.showToast(
                                        msg:  'Paasword Change Successfuly Done',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.white,
                                        textColor: Colors.green,
                                        fontSize: 16.0
                                    );
                                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()));

                                    //print(error);
                                  });
                                  Navigator.pushReplacement(context, customePageTransion(Profile()));
                                  // Navigator.push(context, customePageTransion(
                                  //     Profile()));
                                }
                              }catch(e){
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg: e.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.red,
                                      fontSize: 16.0
                                  );
                                  print(error);
                                });
                                print(e.toString());

                              }
                            }else{
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          error ? Text('data'): Text('')
        ],
      ),
    );
  }
}
