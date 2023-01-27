import 'dart:convert';

import 'package:ezenSacco/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../disp_pages/register.dart';
import '../../routes.dart';
import '../../services/auth.dart';
import '../../wrapper.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({required this.toggleView});


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String url = 'https://ezen.commhighsacco.com';
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final AuthService auth = AuthService();

  bool loading = false;
  bool togglePassword = true;
  bool showServer = false;
  var email ;
  String password = '';
  String error = '';

  TextEditingController _urlCtrl =
  new TextEditingController(text: 'https://ezen.commhighsacco.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
      body: Column(

        children: [
          Padding(padding: EdgeInsets.all(30)),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(
                 'Sign In',
             textAlign: TextAlign.center,
               style: TextStyle(
                 fontSize: 28,
                 color: Colors.blue[800],
                 fontWeight: FontWeight.bold,
                 fontFamily: "Muli"
               ),
             )
           ],
         ),
          SizedBox(height: height * 0.04),
          Container(
              height:height * 0.2,
              child: Image.asset('assets/app_icon.png')
          ),
          SizedBox(height: height * 0.1),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) => val!.isEmpty ? "Enter  Username" : null,
                        onChanged: (val){setState(() => email = val);},
                        decoration: InputDecoration(
                          hintText: 'Username',
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Username",
                          hintStyle: TextStyle(fontSize: width * 0.04),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      TextFormField(
                        validator: (val) => val!.isEmpty ? "Enter  Password" : null,
                        obscureText: togglePassword,
                        onChanged: (val) {setState(() => password = val);},
                        decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          labelText: "Password",
                          hintStyle: TextStyle(fontSize: width * 0.04),
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
                      // CheckboxListTile(
                      //   title: Text("Change Server Url"),
                      //   value: showServer,
                      //   onChanged: (newValue) {
                      //     setState(() {
                      //       showServer = !showServer;
                      //     });
                      //   },
                      //   controlAffinity: ListTileControlAffinity
                      //       .leading, //  <-- leading Checkbox
                      // ),
                      showServer
                          ? TextFormField(
                        controller: _urlCtrl,
                        // validator: (val) => val!.isEmpty ? "Enter  Url" : null,
                        validator: (val) {
                          String patttern =  r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
                          RegExp regExp = new RegExp(patttern);
                          if (!regExp.hasMatch(val!)) {
                            return 'Please enter valid URL';
                          }
                        },
                        onChanged: (val){setState(() => url = val);},
                        decoration: InputDecoration(
                          hintText: 'url',
                          suffixIcon: Icon(Icons.web),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   'Forget password?',
                            //   style: TextStyle(fontSize: 12.0),
                            // ),
                            Expanded(
                              child: ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width * 0.8,
                                child: ElevatedButton(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[800],
                                    padding:  EdgeInsets.all(22.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() { loading = true;});
                                      print(url);
                                      try{
                                        dynamic result = await auth.SignIn(email,password,url);
                                        if(result.email['success'] == 'false'){
                                          setState(() {
                                            loading = false;
                                            Fluttertoast.showToast(
                                                msg:  result.email['message'],
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                //backgroundColor: Colors.white,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          });
                                        }else{
                                          if(result.email['saccoMembershipId'] == null){
                                            Fluttertoast.showToast(
                                              msg:'Wrong Credentials ...',
                                              //msg:  'You Are Not Registered As a Member Of Any Sacco...!!!\n\n Please Contact Your Sacco Branch For More Info'.toUpperCase(),
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 3,
                                                backgroundColor: Colors.white,
                                                textColor: Colors.red,
                                                fontSize: 16.0
                                            );
                                          }else{
                                            setState(() async {
                                              SharedPreferences preferences = await SharedPreferences.getInstance();
                                              var alldata = [url,result.email];
                                              preferences.setString('email', jsonEncode(alldata));
                                              print(preferences);
                                              var showToast = Fluttertoast.showToast(
                                                  msg:  'Login Success',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.white,
                                                  textColor: Colors.green,
                                                  fontSize: 16.0
                                              );
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()));

                                              //print(error);
                                            });
                                          }
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
                                    }
                                  },
                                  // onPressed: () async {
                                  //   print('LOADING ${provider.isLoading}');
                                  //   if (_formKey.currentState.validate()) {
                                  //     _formKey.currentState.save();
                                  //     // if all are valid then go to success screen
                                  //     // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                                  //     try {
                                  //       final result =
                                  //       await InternetAddress.lookup(
                                  //           'google.com');
                                  //       if (result.isNotEmpty &&
                                  //           result[0].rawAddress.isNotEmpty) {
                                  //         print('connected');
                                  //         final logging =
                                  //         await provider.doLogin(context,
                                  //             url: _urlCtrl.text,
                                  //             username: _usernameCtlr.text,
                                  //             password: _passwordCtrl.text);
                                  //         print(
                                  //             'Loading ${provider.isLoading}');
                                  //         if (!logging) {
                                  //           /*simpleToast(
                                  //                     context,
                                  //                     provider.errorMessage,
                                  //                     Colors.red,
                                  //                     TextStyle(color: Colors.white));*/
                                  //           Flushbar(
                                  //             message: provider.errorMessage,
                                  //             backgroundColor: kPrimaryColor,
                                  //             duration: Duration(seconds: 3),
                                  //           )..show(context);
                                  //         }
                                  //       }
                                  //     } catch (e) {
                                  //       Flushbar(
                                  //         message:
                                  //         "No Connection to the remote server.:: ${e.toString()}",
                                  //         backgroundColor: kPrimaryColor,
                                  //         duration: Duration(seconds: 3),
                                  //       )..show(context);
                                  //     }
                                  //   }
                                  // },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(''),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Dont have an account ? ',
                            style: TextStyle(
                              fontFamily: "Muli",
                              fontSize: width * 0.04
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, customePageTransion(Register()));
                            },
                            child: Text('Register',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: "Muli",
                                  fontSize: width * 0.04
                              )
                              ,),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
